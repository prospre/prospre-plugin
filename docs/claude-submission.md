# Claude directory submission

Two submissions in the developer portal at https://claude.ai/directory/manage, from any paid
Claude plan: the **MCP connector** (the server) and the **Plugin bundle** (this repository).
Anthropic pairs them. Both list as Community after an automated scan.

## 1. MCP connector

### Connection

| Field | Value |
|---|---|
| Server URL | `https://www.prospre.io/mcp` |
| Users connect to different URLs | No |

### Tools

Synced from the server. Every tool carries a `title`, `readOnlyHint`, `destructiveHint` and
`openWorldHint`. The list with each description is public at https://www.prospre.io/mcp-server.

### Listing

| Field | Value |
|---|---|
| Name | `Prospre` |
| One-liner (<= 200) | `Log food by talking, plan the week from what you ate, and keep your macros, grocery list and weight in Prospre.` |
| Description (<= 2000) | See below |
| Categories | Productivity (pick the closest name the portal offers) |
| Documentation URL | `https://www.prospre.io/mcp-server` |
| Privacy policy URL | `https://www.prospre.io/privacy-policy` |
| Support contact | the support address shown at `https://www.prospre.io/support` |
| Icon | `https://images.prospre.io/icons/android-chrome-512x512.png` (512 px PNG, also `assets/icon.png` here) |
| Slug | `prospre` (permanent) |

Description:

> Prospre is a meal planning and macro tracking app. Connect it and Claude works in your own
> account. Describe a day and Claude finds each food, picks sensible amounts and logs it to the
> right meals. Ask for next week and Claude plans it from your real averages and adherence,
> keeping the breakfasts you clearly like and fixing your protein. Correct the diary after the
> fact: amounts, units and whether a meal was eaten are all editable. Read the grocery list your
> planned meals generated and tick things off as you shop, or turn it into an Instacart or Amazon
> Fresh order. Review your weigh-ins against your goal and move your calorie and macro targets
> from the day you choose. Every tool is listed with its description at prospre.io/mcp-server,
> and the ones that change your data are marked. Reads run without a prompt; changes ask first.
> A Prospre account is required. The free tier works.

### Use cases

| Field | Value |
|---|---|
| Primary use cases | Log a whole day by talking; plan next week from what you actually ate; fix the diary after the fact; shop straight off the plan; move the targets as the weight moves |
| Prerequisites | A Prospre account (free tier works). No plan or other setup. |
| Reads or writes | Both |

### Company

| Field | Value |
|---|---|
| Company name | Prospre |
| Website | `https://www.prospre.io` |
| Primary contact | the maintainer and the review contact email they choose |

### Authentication

| Field | Value |
|---|---|
| Authentication requirement | Required |
| Authentication methods | OAuth 2.0. The server accepts Client ID Metadata Documents and Dynamic Client Registration; PKCE S256; refresh tokens rotate. |
| Anthropic-held OAuth client | None needed. Leave the client ID and secret empty. |
| Allowed link URIs | `https://www.prospre.io`, `https://app.prospre.io`, `https://images.prospre.io`, `prospre:` |

### Data handling

| Question | Answer |
|---|---|
| Underlying API | Prospre's own first-party API |
| Personal health data | Yes: food intake, weight, body measurements and nutrition targets |
| Sponsored content | No |

### Test & launch

Reviewer account: the email and password the maintainer creates for the reviewer (not stored in this
repository; see the private handover). The account has no MFA and holds two weeks of diary
with planned and eaten meals, saved meals, saved recipes, custom foods, a grocery list, a
weight goal with weigh-ins, and nutrient targets.

Connect instructions for the reviewer:

1. In Claude, open Settings, then Connectors, then Add custom connector.
2. Name it Prospre and paste `https://www.prospre.io/mcp`.
3. Choose Connect. Prospre's sign-in page opens. Sign in with the reviewer email and password.
4. Read the consent screen and choose Approve. Claude shows Prospre as connected.
5. Ask "What did I eat yesterday?" (read) and "Log a banana for breakfast today" (write).

Confirmation: every tool was run through MCP Inspector against production and as a custom
connector in Claude. The per-tool checklist is in `docs/claude-tool-checklist.md`.

### Compliance

All seven acknowledgments: directory guidelines, first-party API usage, financial transactions
(none), AI media generation (none), prompt injection, conversation data collection (none
beyond tool arguments), public documentation (https://www.prospre.io/mcp-server).

## 2. Plugin bundle

| Field | Value |
|---|---|
| Repository | `prospre/prospre-plugin` |
| Plugin path | empty (repository root) |
| Branch or tag | `main` |

Validate, then fix any Blocking finding. `claude plugin validate ./prospre-plugin` passes locally.

Data handling:

| Question | Answer |
|---|---|
| Reads or stores personal data | Reads: diary, weight, targets, recipes, name and email, through the declared Prospre connector. Stores nothing in the plugin. |
| Sends data to services other than its declared connectors | No. One tool in the connector builds Instacart or Amazon Fresh links from the grocery list, and the skill discloses this. |
| Retention | Per Prospre's privacy policy; the plugin keeps nothing. |
| Intended for people under 18 | No. Prospre's terms require users to be 13 or older; the plugin targets adults. |

Four acknowledgments, then choose **GitHub push webhook** for updates. Raise `version` in
`.claude-plugin/plugin.json` on every release.

Submit the connector before or alongside the plugin; the portal pairs them.
