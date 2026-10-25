# ChatGPT plugin submission

Portal: https://platform.openai.com/plugins. Needs an org Owner or a member with Apps
Management Write, and completed business verification so the listing shows Prospre as the
developer. Human review; one active review per plugin; feedback by email.

## Package

Build the ZIP from this repository:

```sh
sh chatgpt/build.sh
```

It writes `chatgpt/prospre-chatgpt.zip` with one top-level folder, `prospre/`, holding
`plugin.json`, `mcp.json`, `skills/` (the shared skills plus `setup`, the onboarding skill)
and `assets/`. Nothing in the ZIP is a credential.

## Metadata (from `chatgpt/plugin.json`)

| Field | Value | Limit |
|---|---|---|
| name | `prospre` | 64 |
| displayName | `Prospre` | 30 |
| shortDescription | `Meal plans and macro tracking` (29) | 30 |
| longDescription | the text in `plugin.json` | 4000 |
| developerName | `Prospre` (the portal takes it from the verified identity) | 80 |
| category | `Productivity` (as the dashboard names it) | one of the dashboard's titles |
| capabilities | 8 lines in `plugin.json` | 20 x 120 |
| websiteURL | `https://www.prospre.io` | HTTPS |
| supportURL | `https://www.prospre.io/support` | HTTPS |
| privacyPolicyURL | `https://www.prospre.io/privacy-policy` | HTTPS |
| termsOfServiceURL | `https://www.prospre.io/terms-of-service` | HTTPS |
| defaultPrompt | 3 prompts in `plugin.json`, no @mentions | 3 x 128 |
| brandColor | `#5734D8` (7.3:1 against white) | >= 2:1 |
| brandColorDark | `#603EDA` (2.4:1 against #212121) | >= 2:1 |
| composerIcon, logo | `assets/icon.png`, `assets/logo.png`, 512 px PNG | square, >= 48 px, <= 5 MiB |
| screenshots | none (no UI component yet) | |

## MCP server

| Field | Value |
|---|---|
| URL | `https://www.prospre.io/mcp` |
| Transport | streamable-http |
| Authentication | OAuth, client mode `cimd` (the server also accepts `dcr`) |
| Client ID / secret | none; `token_endpoint_auth_method` is `none` |

### Domain verification

1. In the portal, open the MCP step and choose **Verify Domain**. Copy the challenge token.
2. Put the token in the website's challenge route and deploy. It is a public proof-of-control
   value, tied to the domain, served the same way as the other well-known files.
3. Confirm `https://www.prospre.io/.well-known/openai-apps-challenge` returns the token alone as
   `text/plain`. Only then press **Verify**.
4. The token stays in place; OpenAI re-checks it on its own schedule.

### Redirect URIs

The portal's MCP page shows the production redirect URI, either the per-app
`https://chatgpt.com/connector/oauth/<id>` or `https://chatgpt.com/connector_platform_oauth_redirect`.
Prospre accepts any `https://` redirect at registration and treats both chatgpt.com forms as a
known client on the consent screen. ChatGPT sends `resource=` on the authorize and token
requests; Prospre ignores it and always issues tokens for `https://www.prospre.io/mcp`.

### Tool annotations

Every tool declares all three hints. Justifications, in case the scan asks:

| Tool | readOnly | destructive | openWorld | Why |
|---|---|---|---|---|
| whoami | true | false | false | Returns the account id and entitlements from the token |
| get_app_settings | true | false | false | Reads the account's settings |
| get_personal_info | true | false | false | Reads profile fields |
| get_food_preferences | true | false | false | Reads allergies and preferences |
| get_food_log | true | false | false | Reads diary days |
| analyze_range | true | false | false | Computes summaries over the diary |
| get_nutrient_targets | true | false | false | Reads the targets for a day |
| get_weight_history | true | false | false | Reads weigh-ins |
| get_weight_goal | true | false | false | Reads the goal |
| get_saved_meals | true | false | false | Reads saved meals |
| get_recent_foods | true | false | false | Reads the recent list |
| get_saved_recipes | true | false | false | Reads saved recipes |
| get_recipe | true | false | false | Reads one recipe |
| search_foods | true | false | false | Searches Prospre's own food database, a bounded set |
| search_recipes | true | false | false | Searches Prospre's own recipe collection |
| get_grocery_list | true | false | false | Reads the list as generated in the app |
| get_grocery_order_link | true | false | true | Changes nothing in Prospre, but sends list items to Instacart or Amazon Fresh to build a link |
| log_food | false | false | false | Adds a diary entry; nothing is removed |
| log_saved_meal | false | false | false | Adds entries |
| edit_logged_food | false | true | false | Overwrites an entry's amount, unit or eaten flag |
| replace_logged_food | false | true | false | Removes one entry and adds another |
| set_meal_eaten | false | false | false | Flips eaten flags; reversible, idempotent |
| delete_logged_food | false | true | false | Removes an entry |
| set_water | false | false | false | Sets a day's total; idempotent |
| create_custom_food | false | false | false | Creates a food |
| create_recipe | false | false | false | Creates a recipe |
| save_recipe | false | false | false | Adds a bookmark |
| unsave_recipe | false | true | false | Removes a bookmark |
| set_recipe_preference | false | false | false | Sets a like or dislike; idempotent |
| save_meal | false | false | false | Creates a saved meal |
| edit_saved_meal | false | true | false | Replaces the meal's contents |
| delete_saved_meal | false | true | false | Removes the saved meal |
| set_grocery_items_bought | false | false | false | Flips bought flags; idempotent |
| log_weight | false | false | false | Records or replaces one day's weigh-in |
| delete_weigh_in | false | true | false | Removes a weigh-in |
| set_weight_goal | false | false | false | Sets the goal from a date; earlier goals stay |
| set_nutrient_targets | false | true | false | Sets targets from a date and deletes later scheduled ones |
| set_food_preferences | false | false | false | Replaces preference lists; removing an allergy needs proof of the current list |
| set_personal_info | false | false | false | Updates profile fields; idempotent |

## Review details

Reviewer account: the email and password the maintainer creates (no MFA, no magic links), entered
under **Review information → Review details**, never in the ZIP. The account holds two weeks
of diary, saved meals, saved recipes, custom foods, a weight goal with
weigh-ins and nutrient targets.

Sign-in instructions for the reviewer: choose Connect on the Prospre plugin, enter the
reviewer email and password on the Prospre page that opens, read the consent screen and
choose Approve.

Commerce: `review.commerce` false. Prospre sells nothing inside ChatGPT. One tool builds an
affiliate-tagged Instacart or Amazon Fresh link, which the skill discloses.

### Positive test cases (exactly 5)

| # | Description | Prompt | Tools triggered | Expected behaviour |
|---|---|---|---|---|
| 1 | Log a day by talking | "Log my day: porridge with blueberries and a scoop of whey for breakfast, a chicken burrito bowl for lunch, two black coffees." | get_app_settings, get_recent_foods, search_foods, log_food, get_food_log | Each food is found, logged to breakfast or lunch for today with a stated amount, and the day's totals are shown against target |
| 2 | Plan next week | "Look at the last two weeks and plan next week around it. Keep the breakfasts I clearly like and fix my protein." | analyze_range, get_nutrient_targets, get_food_preferences, get_saved_meals, get_saved_recipes, log_saved_meal, log_food | A seven-day plan is written to the future diary with eaten false, repeats the frequent breakfasts, avoids allergens, and meets protein |
| 3 | Fix the diary | "I only ate half that burrito bowl, and skip dinner yesterday, I never had it." | get_food_log, edit_logged_food, set_meal_eaten | The burrito bowl's amount is halved and yesterday's dinner is marked not eaten; corrected totals are shown |
| 4 | Log a weigh-in and read the trend | "I weighed 82.4 kg this morning. How am I tracking against my goal?" | get_app_settings, log_weight, get_weight_history, get_weight_goal | The weigh-in is recorded for today in the account's unit, and the change since the goal's start is compared with the goal's target and date |
| 5 | Move the targets | "I have been flat for three weeks. Adjust my calories from Monday." | get_weight_history, get_weight_goal, get_nutrient_targets, analyze_range, set_nutrient_targets | The trend and intake are read out, a moderate change is proposed and confirmed, and the targets are set from the coming Monday with a note that later scheduled targets are superseded |

### Negative test cases (exactly 3)

| # | Description | Prompt |
|---|---|---|
| 1 | General cooking question with no account action | "How long should I roast a whole chicken at 200 C?" |
| 2 | Unit conversion with no account action | "How many grams are in a cup of cooked rice?" |
| 3 | Another app's data | "Export my Strava runs from last month." |

In each, the assistant answers or declines without calling a Prospre tool.

### Demo video

`review.demo_recording_url`: the maintainer records the five positive cases on web and on mobile
web and pastes an accessible URL.

### Release notes

`publication.release_notes`: "Version 1.0.0. First release: six skills (setup, log-day,
plan-week, fix-diary, shop, adjust-targets) over Prospre's MCP server with OAuth."

## Local test loop

1. ChatGPT → Plugins → Add custom MCP server → `https://www.prospre.io/mcp`, OAuth. Sign in
   with the reviewer account. Run every tool from chat; check the consent screen reads
   correctly inside ChatGPT's flow.
2. Create as a plugin; copy the `plugin_asdk_app...` id from the URL.
3. Put the built folder in a local marketplace (`~/.agents/plugins/marketplace.json` with
   `source.path`, `policy.installation`, `policy.authentication`, `category`), restart the
   ChatGPT desktop app, install from the Plugins Directory, and test the skills and the
   onboarding skill in a fresh chat. Test on mobile web too.

## After approval

Publish plugin. OpenAI rescans the server daily; press Rescan after a deploy that changes
tools. Upload a new ZIP only for metadata, skills or assets, and bump `version`.
