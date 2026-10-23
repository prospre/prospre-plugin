---
name: get-started
description: Connect a Prospre account and show what the assistant can do with it. Use when the user asks what Prospre can do here, has just installed the plugin, or is not signed in yet.
---

# Get started with Prospre

Prospre is a meal planning and macro tracking app. This plugin connects the assistant to the
user's own Prospre account through the Prospre MCP server at `https://www.prospre.io/mcp`.

## Check the connection

1. Call `whoami`. A result means the account is connected.
2. If the server answers that the user is not signed in, tell them to connect Prospre from
   the plugin's connector settings, sign in with their Prospre account, and approve the
   connection. They need a Prospre account; the free tier is enough. There is no API key.
3. Call `get_app_settings` once connected. It says whether the user works in metric or
   imperial units and whether they count net or total carbs. Use those units in every reply.

## Say what is possible

Offer these, in the user's words, and start whichever they pick:

- **Log a day by talking**: "I had porridge and a coffee for breakfast and a chicken wrap for lunch."
- **Plan next week from what they actually ate**: "Plan next week around the last two weeks."
- **Fix the diary**: "I only ate half that burrito."
- **Shop off the plan**: "What do I still need to buy this weekend?"
- **Move the targets as the weight moves**: "I have been flat for three weeks. Adjust my calories."

## Two rules for every Prospre task

- Dates are `YYYYMMDD` in the user's own timezone, and the server never assumes "today".
  Work out the date from the conversation, or ask, before calling a dated tool.
- Read `get_food_preferences` before suggesting any food. It lists the user's allergies, and
  no other tool will warn about them.
