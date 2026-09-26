## OAuth & User Authentication Sub-System

type
  OAuthProvider* = ref object
    clientId*: string
    clientSecret*: string
    redirectUrl*: string
    scopes*: seq[string]

  User* = object
    id*: string
    name*: string
    email*: string

  OAuthToken* = object
    accessToken*: string
    refreshToken*: string
    expiresIn*: int

proc newGitHubOAuthProvider*(clientId, clientSecret: string, scopes: seq[string] = @["user:email"]): OAuthProvider =
  OAuthProvider(
    clientId: clientId,
    clientSecret: clientSecret,
    redirectUrl: "http://localhost:8550/oauth_callback",
    scopes: scopes
  )

proc newGoogleOAuthProvider*(clientId, clientSecret: string, scopes: seq[string] = @["profile", "email"]): OAuthProvider =
  OAuthProvider(
    clientId: clientId,
    clientSecret: clientSecret,
    redirectUrl: "http://localhost:8550/oauth_callback",
    scopes: scopes
  )
