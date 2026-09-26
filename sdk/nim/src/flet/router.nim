## Client-Side Route Matcher Engine

import tables
import flet/control

type
  RouteHandler* = proc (params: Table[string, string]): Control {.closure.}

  Router* = ref object
    routes: Table[string, RouteHandler]

proc newRouter*(): Router =
  Router(routes: initTable[string, RouteHandler]())

proc addRoute*(r: Router, path: string, handler: RouteHandler) =
  r.routes[path] = handler

proc matchRoute*(r: Router, url: string): Control =
  ## Simple pattern route matching engine.
  if r.routes.hasKey(url):
    let handler = r.routes[url]
    return handler(initTable[string, string]())

  if r.routes.hasKey("/"):
    return r.routes["/"](initTable[string, string]())

  return newControl("Text")
