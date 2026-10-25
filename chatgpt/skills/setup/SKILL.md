---
name: setup
description: Onboarding for the Prospre plugin. Connect the user's Prospre account and show what the assistant can do with it. Runs when the plugin is installed and whenever the user asks what Prospre can do here.
---

# Set up Prospre

Prospre is a meal planning and macro tracking app. This plugin connects ChatGPT to the user's
own Prospre account through the Prospre MCP server at `https://www.prospre.io/mcp`.

## Connect the account

1. Call `whoami`. A result means the account is connected; go to the next section.
2. If Prospre is not connected yet, tell the user to choose Connect on the Prospre plugin,
   sign in with their Prospre account on the page that opens, and approve the connection.
   They need a Prospre account. There is no API key. The consent screen lists exactly what
   the connection can read and change.
3. Once connected, call `get_app_settings`. It says whether the user works in metric or
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
