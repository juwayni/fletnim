## Thread-Safe In-Memory PubSub Bus Engine

import tables, locks, sequtils

type
  PubSubCallback* = proc (args: seq[string]) {.closure.}

  PubSubHub* = ref object
    lock: Lock
    subscribers: Table[string, seq[PubSubCallback]]
    topicSubscribers: Table[string, Table[string, seq[PubSubCallback]]]
    subscriberTopics: Table[string, Table[string, seq[PubSubCallback]]]

proc newPubSubHub*(): PubSubHub =
  result = PubSubHub(
    subscribers: initTable[string, seq[PubSubCallback]](),
    topicSubscribers: initTable[string, Table[string, seq[PubSubCallback]]](),
    subscriberTopics: initTable[string, Table[string, seq[PubSubCallback]]]()
  )
  initLock(result.lock)

proc free*(hub: PubSubHub) =
  deinitLock(hub.lock)

proc subscribe*(hub: PubSubHub, sessionId: string, handler: PubSubCallback) =
  withLock(hub.lock):
    if not hub.subscribers.hasKey(sessionId):
      hub.subscribers[sessionId] = @[]
    hub.subscribers[sessionId].add(handler)

proc subscribeTopic*(hub: PubSubHub, sessionId: string, topic: string, handler: PubSubCallback) =
  withLock(hub.lock):
    if not hub.topicSubscribers.hasKey(topic):
      hub.topicSubscribers[topic] = initTable[string, seq[PubSubCallback]]()
    if not hub.topicSubscribers[topic].hasKey(sessionId):
      hub.topicSubscribers[topic][sessionId] = @[]
    hub.topicSubscribers[topic][sessionId].add(handler)

    if not hub.subscriberTopics.hasKey(sessionId):
      hub.subscriberTopics[sessionId] = initTable[string, seq[PubSubCallback]]()
    if not hub.subscriberTopics[sessionId].hasKey(topic):
      hub.subscriberTopics[sessionId][topic] = @[]
    hub.subscriberTopics[sessionId][topic].add(handler)

proc unsubscribe*(hub: PubSubHub, sessionId: string) =
  withLock(hub.lock):
    hub.subscribers.del(sessionId)

proc unsubscribeTopic*(hub: PubSubHub, sessionId: string, topic: string) =
  withLock(hub.lock):
    if hub.topicSubscribers.hasKey(topic):
      hub.topicSubscribers[topic].del(sessionId)
      if hub.topicSubscribers[topic].len == 0:
        hub.topicSubscribers.del(topic)
    if hub.subscriberTopics.hasKey(sessionId):
      hub.subscriberTopics[sessionId].del(topic)
      if hub.subscriberTopics[sessionId].len == 0:
        hub.subscriberTopics.del(sessionId)

proc unsubscribeAll*(hub: PubSubHub, sessionId: string) =
  hub.unsubscribe(sessionId)
  withLock(hub.lock):
    if hub.subscriberTopics.hasKey(sessionId):
      let topics = toSeq(hub.subscriberTopics[sessionId].keys)
      for topic in topics:
        if hub.topicSubscribers.hasKey(topic):
          hub.topicSubscribers[topic].del(sessionId)
      hub.subscriberTopics.del(sessionId)

proc sendAll*(hub: PubSubHub, message: string) =
  var handlersToCall: seq[PubSubCallback] = @[]
  withLock(hub.lock):
    for _, handlers in hub.subscribers:
      for handler in handlers:
        handlersToCall.add(handler)
  for handler in handlersToCall:
    handler(@[message])

proc sendAllOnTopic*(hub: PubSubHub, topic: string, message: string) =
  var handlersToCall: seq[PubSubCallback] = @[]
  withLock(hub.lock):
    if hub.topicSubscribers.hasKey(topic):
      for _, handlers in hub.topicSubscribers[topic]:
        for handler in handlers:
          handlersToCall.add(handler)
  for handler in handlersToCall:
    handler(@[topic, message])

proc sendOthers*(hub: PubSubHub, exceptSessionId: string, message: string) =
  var handlersToCall: seq[PubSubCallback] = @[]
  withLock(hub.lock):
    for sessionId, handlers in hub.subscribers:
      if sessionId != exceptSessionId:
        for handler in handlers:
          handlersToCall.add(handler)
  for handler in handlersToCall:
    handler(@[message])
