# Grok Build marketplace entry

Target: a fork of https://github.com/xai-org/plugin-marketplace, branch from `main`, one
entry appended to `.grok-plugin/marketplace.json`. The repo must be public and the pinned
commit reachable before the PR opens, or CI fails fetching it.

## Catalog entry

Replace `<sha>` with the output of
`git ls-remote https://github.com/prospre/prospre-plugin.git HEAD` once `main` holds the
plugin.

```json
{
  "name": "prospre",
  "description": "Prospre meal planning and macro tracking. Log a day of food by describing it, plan the week from what you actually ate, fix the diary, read and tick off the grocery list, and move your targets as your weight moves, in your own Prospre account over its OAuth MCP server.",
  "category": "productivity",
  "source": {
    "source": "url",
    "url": "https://github.com/prospre/prospre-plugin.git",
    "sha": "<sha>"
  },
  "homepage": "https://www.prospre.io",
  "keywords": ["prospre", "prospre meal plan", "prospre macros", "prospre diary"],
  "domains": ["prospre.io"]
}
```

## Commands in the fork

```sh
python3 scripts/generate-plugin-index.py
python3 scripts/validate-catalog.py
python3 scripts/generate-plugin-index.py --check
git add .grok-plugin/marketplace.json .grok-plugin/plugin-index.json
git commit -m "Add prospre"
```

## PR text (template filled in)

**Title:** Add prospre

```
## What this PR does

Adds the Prospre plugin: skills and the MCP server manifest for Prospre, a meal planning
and macro tracking app.

- Plugin name: prospre
- Type: remote source
- Source URL + pinned SHA (remote), or vendored path (local): https://github.com/prospre/prospre-plugin.git @ <sha>
- Homepage: https://www.prospre.io

## Ownership

- [x] I own this plugin or have the right to distribute it.
- [x] The `source` repo is published under our official org (or I've explained why not below).

## Checklist

- [x] Added/updated exactly one entry in `.grok-plugin/marketplace.json` (valid JSON, kebab-case `name`).
- [x] Remote source pins a full 40-char lowercase commit `sha`, and that commit is public + reachable.
- [x] Regenerated `.grok-plugin/plugin-index.json` (`python3 scripts/generate-plugin-index.py`).
- [x] `python3 scripts/validate-catalog.py` passes locally.
- [x] `python3 scripts/generate-plugin-index.py --check` passes locally.
- [x] `homepage` + clear `description` set; local plugins include `README.md` + `.grok-plugin/plugin.json`.
- [x] License is stated.

## Security

- [x] No `curl | bash`, remote-code download/exec, or `postinstall` RCE.
- [x] No reading/exfiltration of secrets, tokens, `.env`, or env vars.
- [x] Hooks and MCP scope are least-privilege.
- Network endpoints this plugin calls (and why): https://www.prospre.io/mcp, Prospre's MCP server, the only endpoint; it is where the user's Prospre account is read and updated.
- Credentials/permissions it requires (and why): an OAuth token that Prospre issues when the user signs in and approves the connection in the browser. No API key, no secret in the plugin. The plugin is Markdown and JSON only: no hooks, scripts or binaries.

## Notes for reviewers

The source is the prospre org's own repository. The same skills ship in Claude's and
ChatGPT's directories. Documentation for the server: https://www.prospre.io/mcp-server.
```

## Updating later

Bump the `sha`, regenerate the index, open a new PR. Do not add a second entry.
