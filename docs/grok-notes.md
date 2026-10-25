# Grok notes

As of 2026-10-22 xAI documents no way for a third party to be listed in the grok.com
Connectors catalog. Three paths exist:

1. **Custom connector** in the Grok apps: each user adds `https://www.prospre.io/mcp` under
   Connectors → New Connector → Custom. Reaches every Grok user today. Documented on
   https://www.prospre.io/mcp-server under Grok.
2. **Grok Build plugin** through the official marketplace, `xai-org/plugin-marketplace`.
   Reaches the Grok Build CLI. The catalog entry and PR text are in `xai-marketplace-pr.md`.
3. **Apps catalog partnership**: outreach only, see the note at the end.

## Observed OAuth behaviour

Grok Build CLI 1.0.50, 2026-10-22, before sign-in:

```
$ grok mcp add --transport http prospre https://www.prospre.io/mcp
Added HTTP MCP server 'prospre' with URL: https://www.prospre.io/mcp to user config
File modified: ~/.grok/config.toml

$ grok mcp list
  prospre: https://www.prospre.io/mcp

$ grok mcp doctor
  prospre (http: https://www.prospre.io/mcp)
    ✓ server started (0.5s)
    ✗ handshake failed (... Auth required, when send initialize request)
```

The doctor log shows Grok Build read Prospre's 401 challenge correctly:
`resource_metadata="https://www.prospre.io/.well-known/oauth-protected-resource/mcp", scope="agent"`.

Still to observe, because the sign-in opens a browser (the maintainer):

| Question | Where to look | Answer |
|---|---|---|
| Does grok.com use DCR (`POST /oauth/register`) or a Client ID Metadata Document? | Prospre server logs during the first custom-connector sign-in | |
| Exact `redirect_uri` host for grok.com and for the Grok app | the consent screen shows it under "sent to" | |
| Scopes requested | the authorize request's `scope` | |
| Is `resource=` sent? | the authorize and token requests | |
| Same questions for Grok Build (loopback port, DCR or CIMD) | the consent screen during `/mcps` → `i` | |

Once the grok.com redirect host is known, add it to the consent screen's list of known
first-party hosts so Grok gets the calm panel.

## Test matrix

| Surface | Status |
|---|---|
| grok.com custom connector, every tool | not yet run (needs the maintainer's sign-in) |
| Grok iOS or Android app | not yet run |
| Grok Build CLI with `--plugin-dir`, each skill | not yet run past the pre-auth doctor check |

## Partnership note (for the maintainer to send via x.ai Partners / Contact Sales)

> Hello. Prospre (https://www.prospre.io) is a meal planning and macro tracking app with a
> production MCP server at https://www.prospre.io/mcp. It uses OAuth 2.0 with PKCE, supports
> Client ID Metadata Documents and dynamic registration, and exposes 39 tools over a user's
> diary, meal plan, recipes, grocery list, weight and targets. It is listed in Claude's
> connector directory and ChatGPT's plugin directory [update once live], and Grok users can
> already add it as a custom connector. Is there a path to be listed as a catalog connector in
> Grok, and what does it require? Thank you.

Record xAI's answer here. No engineering work until they answer.
