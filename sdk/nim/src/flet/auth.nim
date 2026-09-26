## Comprehensive OAuth & User Authentication Sub-System for Nim Flet SDK

type
  OAuthToken* = object
    accessToken*: string
    refreshToken*: string
    tokenType*: string
    expiresIn*: int
    scope*: seq[string]

  User* = object
    id*: string
    name*: string
    email*: string
    avatarUrl*: string

  Group* = object
    id*: string
    name*: string

  OAuthProvider* = ref object of RootObj
    id*: string
    clientId*: string
    clientSecret*: string
    authorizationEndpoint*: string
    tokenEndpoint*: string
    userEndpoint*: string
    redirectUrl*: string
    scopes*: seq[string]

  GitHubOAuthProvider* = ref object of OAuthProvider
  GoogleOAuthProvider* = ref object of OAuthProvider
  AzureOAuthProvider* = ref object of OAuthProvider
  Auth0OAuthProvider* = ref object of OAuthProvider
    domain*: string

  Authorization* = ref object
    provider*: OAuthProvider
    token*: OAuthToken
    user*: User

  AuthorizationService* = ref object
    activeAuthorizations*: seq[Authorization]

proc newOAuthProvider*(id, clientId, clientSecret, authEndpoint, tokenEndpoint, userEndpoint: string, scopes: seq[string] = @[]): OAuthProvider =
  OAuthProvider(
    id: id,
    clientId: clientId,
    clientSecret: clientSecret,
    authorizationEndpoint: authEndpoint,
    tokenEndpoint: tokenEndpoint,
    userEndpoint: userEndpoint,
    redirectUrl: "http://localhost:8550/oauth_callback",
    scopes: scopes
  )

proc newGitHubOAuthProvider*(clientId, clientSecret: string, scopes: seq[string] = @["user:email"]): GitHubOAuthProvider =
  GitHubOAuthProvider(
    id: "github",
    clientId: clientId,
    clientSecret: clientSecret,
    authorizationEndpoint: "https://github.com/login/oauth/authorize",
    tokenEndpoint: "https://github.com/login/oauth/access_token",
    userEndpoint: "https://api.github.com/user",
    redirectUrl: "http://localhost:8550/oauth_callback",
    scopes: scopes
  )

proc newGoogleOAuthProvider*(clientId, clientSecret: string, scopes: seq[string] = @["profile", "email"]): GoogleOAuthProvider =
  GoogleOAuthProvider(
    id: "google",
    clientId: clientId,
    clientSecret: clientSecret,
    authorizationEndpoint: "https://accounts.google.com/o/oauth2/v2/auth",
    tokenEndpoint: "https://oauth2.googleapis.com/token",
    userEndpoint: "https://www.googleapis.com/oauth2/v3/userinfo",
    redirectUrl: "http://localhost:8550/oauth_callback",
    scopes: scopes
  )

proc newAzureOAuthProvider*(clientId, clientSecret, tenantId: string, scopes: seq[string] = @["User.Read"]): AzureOAuthProvider =
  AzureOAuthProvider(
    id: "azure",
    clientId: clientId,
    clientSecret: clientSecret,
    authorizationEndpoint: "https://login.microsoftonline.com/" & tenantId & "/oauth2/v2.0/authorize",
    tokenEndpoint: "https://login.microsoftonline.com/" & tenantId & "/oauth2/v2.0/token",
    userEndpoint: "https://graph.microsoft.com/v1.0/me",
    redirectUrl: "http://localhost:8550/oauth_callback",
    scopes: scopes
  )

proc newAuth0OAuthProvider*(domain, clientId, clientSecret: string, scopes: seq[string] = @["openid", "profile", "email"]): Auth0OAuthProvider =
  Auth0OAuthProvider(
    id: "auth0",
    domain: domain,
    clientId: clientId,
    clientSecret: clientSecret,
    authorizationEndpoint: "https://" & domain & "/authorize",
    tokenEndpoint: "https://" & domain & "/oauth/token",
    userEndpoint: "https://" & domain & "/userinfo",
    redirectUrl: "http://localhost:8550/oauth_callback",
    scopes: scopes
  )

proc newAuthorizationService*(): AuthorizationService =
  AuthorizationService(activeAuthorizations: @[])
