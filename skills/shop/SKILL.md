---
name: shop
description: Read and tick off the Prospre grocery list, or turn it into an online order. Use when the user asks what to buy, says they bought something, or wants an Instacart or Amazon Fresh link.
---

# Shop straight off the plan

The Prospre app generates a grocery list from the planned meals. The assistant reads that list,
ticks items off as they go in the basket, and can turn the rest into an ordering link.

## Tools, in order

1. `get_grocery_list`: the items, the dates the list covers, and which are already bought. The
   list is a snapshot the user generated in the app; if they changed the plan since, tell them
   to regenerate it in the app rather than inventing items.
2. `set_grocery_items_bought` with the food ids the user names, as they shop. `bought: false`
   puts something back.
3. `get_grocery_order_link` with `provider` `instacart` or `amazon_fresh` when the user wants to
   order. Only unbought items are included.

## Before sharing an order link

Say both of these, because the tool itself does: the item names and quantities are sent to the
chosen store to build the link, and the link is affiliate-tagged, so Prospre earns a commission on
qualifying purchases. Ask the user to check the cart before ordering. An Instacart link expires
after 7 days.

## A good reply

Group what is still needed by aisle or by the meals that need it, with the quantities from the
list. Note what is already bought. When an item is ticked off, confirm it in one line.
