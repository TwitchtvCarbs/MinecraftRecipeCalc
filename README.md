# Minecraft Recipe Project
## Objectives:
1. Get recipe data from recipe json files.

2. Create a database with those recipes.
Example of some data that we will be storing is as follows and will be stored in a single .json file or each group could have it's own file in the end:

	Output Item (Item Name, Amount Requested, minOutput, Item Group, Assigned ID)
	Input Items (Item Names, Amounts Required, minInput, Item Groups ,Assigned IDs)

3. When a user inputs an item and how many of that item they will need, the system will retrieve from our new database and find what materials and how much of each material is required. The system will also have some minimum input / outputs for instance Iron Bars will output a minimum of 16 for it's recipe which cost 6 Iron Ingots meaning that if the user only needs 10, they will still need to place in the minimum amount of the required items aka 6 Iron Ingots. If they need 17 they would need a minimum of 12 Ingots etc.

## Current Functionality:
Recipes can be searched via an input text string
which can be any assortment of capitalized or lower
case and can also have spaces too. Only works
when auto load is off.

Recipes will show inputs and outputs now with
mod name for each material and will display
it separate. This will end up in the UI under the name
before too long.

Auto load will load in 512/524 recipes in to the
database. This database will contain only needed
information that is used for calculations.(No 
recipe patterns or furnace XP etc.) Might add more
later.

The few recipes that are not able to load are
do to the nesting of recipes which are and/or
types of recipes. (fire_charge for instance can use
either charcoal OR coal in its shapeless recipe.)