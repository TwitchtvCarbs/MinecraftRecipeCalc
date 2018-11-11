#Minecraft Recipe Project
##Objectives:
1. Get recipe data from recipe json files.

2. Create a database with those recipes.
Example of some data that we will be storing is as follows and will be stored in a single .json file or each group could have it's own file in the end:

	Output Item (Item Name, Amount Requested, minOutput, Item Group, Assigned ID)
	Input Items (Item Names, Amounts Required, minInput, Item Groups ,Assigned IDs)

3. When a user inputs an item and how many of that item they will need, the system will retrieve from our new database and find what materials and how much of each material is required. The system will also have some minimum input / outputs for instance Iron Bars will output a minimum of 16 for it's recipe which cost 6 Iron Ingots meaning that if the user only needs 10, they will still need to place in the minimum amount of the required items aka 6 Iron Ingots. If they need 17 they would need a minimum of 12 Ingots etc.

