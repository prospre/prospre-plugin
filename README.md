# Prospre plugin

This plugin connects an AI assistant to a Prospre account. Prospre is a meal planning and
macro tracking app. With the plugin, the assistant can log a whole day of food from a
description, plan the coming week from what the user actually ate, fix diary entries after the
fact, read and tick off the grocery list, and adjust nutrition targets as the user's weight
moves. It works in Claude, ChatGPT, Grok Build, Claude Code and any other client that can load
the files in this repository.

## What is in the repository

- `.mcp.json` points the assistant at Prospre's MCP server, `https://www.prospre.io/mcp`.
- `skills/` holds one skill per workflow. Each names the Prospre tools to call, in order, the
  defaults to apply, and what a good reply looks like. `get-started` explains the connection
  to a new user.
- `.claude-plugin/plugin.json` is the plugin manifest.
- `chatgpt/` holds the manifest and build script for the ChatGPT package.
- `docs/` holds the submission notes for each directory.

The plugin is Markdown and JSON only. It runs no scripts, installs no packages and sets no hooks.

## Using it

**Claude** (web, desktop and mobile): add Prospre from the plugin directory, then connect the
bundled Prospre connector on the plugin's Connectors tab and sign in with a Prospre account.

**Claude Code**: `claude --plugin-dir /path/to/prospre-plugin`, then `/mcp`, choose `prospre` and
authenticate. The skills appear as `/prospre:log-day` and so on.

**Grok Build**: `grok --plugin-dir /path/to/prospre-plugin`, or install it from the Grok Build
marketplace once listed. Authentication starts in the browser on first use.

**ChatGPT**: install Prospre from the plugin directory once listed, or build the package with
`chatgpt/build.sh` and add it through a local marketplace.

Every path needs a Prospre account. The free tier is enough. There is no API key: the assistant
signs in through Prospre's OAuth consent screen, and the user approves exactly what it can
reach.

## What the plugin sends, and where

The assistant talks to one network endpoint, `https://www.prospre.io/mcp`, over HTTPS with the
OAuth token Prospre issues at sign-in. The credential it needs is that token; the plugin stores
nothing itself and asks for no other secret. When a skill runs a Prospre tool, the request
carries what the user asked for, such as a food name, an amount, a date or a weight, and the
result comes back to the assistant: diary entries, saved meals and recipes, the grocery list,
weigh-ins, targets, and the name and email on the account. The assistant's own provider then
handles that result under its privacy policy. Prospre does not receive the conversation,
only the tool requests. Prospre's privacy policy is at
https://www.prospre.io/privacy-policy, and the data each tool reads or changes is listed on
https://www.prospre.io/mcp-server.

One tool, `get_grocery_order_link`, also sends the names and quantities on the grocery list
to Instacart or Amazon Fresh to build an ordering link, and that link is affiliate-tagged.
The skill that uses it tells the user both.

## Trademark and license

Prospre is a trademark of Prospre. Use of the service is governed by
https://www.prospre.io/terms-of-service. The files in this repository are released under the
MIT license in `LICENSE`.
