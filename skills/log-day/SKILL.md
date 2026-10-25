---
name: log-day
description: Log a whole day of food in Prospre from a spoken or typed description. Use when the user lists what they ate or plan to eat, names a meal to log, or reads out a barcode or nutrition label.
---

# Log a day by talking

The user describes the day in one go. The assistant finds each food, picks sensible amounts,
and writes them to the right meals on the right day. One pass instead of twenty taps.

## Tools, in order

1. `get_app_settings` once per conversation: units, net or total carbs, and the user's current
   local date and time. Prefer a date the user states over the server's derived one.
2. For each food the user names:
   - `get_recent_foods` first. The version of a food this user already logs beats a fresh search.
   - Otherwise `search_foods` with `query`, or with `barcode` when the user reads a number off a package.
   - If nothing fits and the user has the label, `create_custom_food` with the figures **per serving**
     exactly as the label states them, then log that id.
3. `log_food` with the food id, `date`, meal, `amount` and `unit`. Several foods in one meal are
   several calls; the server keeps them in order. A whole saved meal ("my usual breakfast") is
   one `log_saved_meal` call.
4. `get_food_log` for that date with `detail: "totals"` to close the loop.

## Defaults

- Meal: breakfast, lunch, dinner or snacks from the time of day the user implies.
- Amount: one serving of the food as stored, unless the user gives a quantity. Say which amount
  was assumed so the user can correct it.
- Unit: the food's own stored unit. If `log_food` refuses a unit, use one from the list it returns.
- `eaten`: true for today and past days, false for a future day, which makes it part of the plan.
- A food the assistant cannot match is reported, not guessed. Never log a stand-in silently.

## A good reply

A short table of what was logged: meal, food, amount, calories and macros. Then the day's totals
against the targets from `get_nutrient_targets` for that date, in the user's units. End with any
item that was skipped or assumed, so the user can fix it in one line.
