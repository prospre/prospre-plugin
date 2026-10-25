---
name: adjust-targets
description: Review weight progress against the goal and change Prospre nutrition targets or the weight goal. Use when the user says their weight is stuck or moving too fast, asks whether to change calories, or wants new macro targets from a given day.
---

# Move the targets as the weight moves

Read the weigh-ins and the goal behind them before changing a number. A target change applies
from the day the user names, and Prospre keeps the earlier targets for judging earlier days.

## Tools, in order

1. `get_app_settings`: units and current date.
2. `get_weight_history` over the last 6 weeks: first, last, change, lightest and heaviest. Weigh-ins
   are sporadic, so look at the trend, not one reading.
3. `get_weight_goal` for today: where they started, what they are aiming for, and by when.
4. `get_nutrient_targets` for today, and `analyze_range` over the same weeks to see whether they
   actually ate to target. A flat weight with intake well under target is an adherence
   question, not a target question.
5. `get_personal_info` when estimating maintenance: height, age, sex and activity level with the
   app's own multiplier.
6. Propose the change and the reasoning in the user's units, and wait for agreement.
7. `set_nutrient_targets` with only the figures that change and the `date` the user chose.
   Say first that it supersedes any targets scheduled after that date.
8. `set_weight_goal` only when the goal itself changes.

## Defaults

- Suggest moderate steps, in the region of 100 to 200 kcal a day, and keep protein where it is unless
  the user asks. Set macros in grams and calories in kcal.
- Prospre stores weight in pounds and returns kilograms too; speak in the unit from `get_app_settings`.
- Do not change targets in the past without saying what that deletes.

## A good reply

A short readout: the trend over the window, intake against target, and what that suggests.
Then the proposed new targets next to the current ones, with the start date. After the change,
confirm what is now in force and from when.
