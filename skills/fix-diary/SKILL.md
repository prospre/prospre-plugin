---
name: fix-diary
description: Correct entries already in the Prospre diary. Use when the user says they ate more or less than logged, skipped a meal, swapped a food, or wants something removed from a day.
---

# Fix the diary after the fact

Amounts, units and whether a meal was eaten are all editable, so the record can match the day
instead of the plan.

## Tools, in order

1. `get_food_log` for the day, `detail: "names"`. Every entry has a `uuid`; edits are addressed by
   uuid, never by position.
2. One of:
   - `edit_logged_food`: change the amount, the unit, or `eaten` on one entry. "Half that burrito" is
     the same entry with half the amount.
   - `set_meal_eaten`: mark a whole meal eaten or not eaten. "Skip dinner yesterday, I never had it"
     is `eaten: false` on dinner, which keeps the plan but removes it from the eaten totals.
   - `replace_logged_food`: swap one entry for a different food in the same place. Find the new food
     with `search_foods` or `get_recent_foods` first.
   - `delete_logged_food`: remove an entry outright. Confirm with the user before deleting, and
     prefer `set_meal_eaten` when the question is only whether they ate it.
3. `get_food_log` with `detail: "totals"` to show the corrected day.

## Defaults

- "Yesterday" and "this morning" resolve against the user's local date from `get_app_settings`
  or from the conversation; ask if the day is unclear.
- When an edit changes the unit, use one the food accepts. A refused unit comes back with the
  accepted list.
- A replacement starts as not eaten unless the user says they ate it; pass `eaten: true` then.

## A good reply

State exactly what changed, entry by entry, and the day's new eaten totals against target. If
something could not be found in the diary, say so rather than editing a similar entry.
