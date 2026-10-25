---
name: plan-week
description: Plan the coming days or week in Prospre from what the user actually ate. Use when the user asks for a meal plan, wants next week planned, or asks to fix a shortfall such as protein going forward.
---

# Plan next week from what the user actually ate

Future dates in the Prospre diary are the meal plan. Planning a day means logging it with
`eaten: false`. The plan should come from the user's real averages and habits, not a template.

## Tools, in order

1. `get_app_settings`: units, carb mode, current date.
2. `analyze_range` over the last 14 days: averages per day, adherence against the targets that
   applied, which weekdays differ, and how many days were logged. Say so when the record is thin.
3. `get_nutrient_targets` for the first planned day.
4. `get_food_preferences`: allergies, diet type, dislikes, liked and disliked recipes, recurring
   meals. **Nothing in the plan may contain an allergen.**
5. `get_saved_meals` and `get_saved_recipes`: what the user already likes to repeat. Keep the
   breakfasts and meals they clearly eat often, as the user asked.
6. `search_recipes` only for the gaps the saved items do not fill.
7. Write the plan: `log_saved_meal` for a saved meal, `log_food` with `eaten: false` for each
   food or recipe (unit `Serving` for a recipe), day by day.
8. On request, `save_meal` to keep a planned meal as a named saved meal, or `create_recipe` for a
   dish the user wants to build from ingredients.

## Defaults

- Plan seven days from tomorrow unless the user names a range.
- Hit the daily calorie and protein targets within about 5%; carbs and fat can flex.
- Repeat breakfasts across the week; vary lunches and dinners. Reuse leftovers on the next day
  when a recipe makes several servings.
- Do not overwrite a future day that already has foods without saying what is there first.
  `get_food_log` for the range shows it.

## A good reply

One line on what the last two weeks looked like and what the plan changes. Then a day-by-day
list with each meal and the day's totals against target. Mention that the plan is in the
Prospre app as the diary for those days, and that the grocery list can be generated from it.
