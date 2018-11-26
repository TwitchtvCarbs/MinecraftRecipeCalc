extends Node
var recipeToLoad = "diamond_axe"

var url_database_recipe = "res://Recipes//1.13.2 JsonRecipes//"+String(recipeToLoad)+".json"
var recipe_type
var recipe_output
var input_item = []
var input_amount = []
var inputString = "\n"
var output_item
var output_amount
var item_group
var hasTag
var arrayModifier = 0 #Used when an recipe doesn't have a group and sets to one less then recipes with a group.
var itemData = {}#Create a dictionary for temp items recipe data
var recipe = []

func init(loadRecipe):
	recipeToLoad = loadRecipe
	url_database_recipe = "res://Recipes//1.13.2 JsonRecipes//"+String(recipeToLoad)+".json"
	recipe_type = null
	recipe_output = null
	input_item = []
	input_amount = []
	inputString = "\n"
	output_item = null
	output_amount = null
	item_group = null
	hasTag = null
	arrayModifier = 0 #Used when an recipe doesn't have a group and sets to one less then recipes with a group.
	itemData = {}#Create a dictionary for temp items recipe data
	recipe = []
	
func _run():
	itemData = Global_DataParser.load_data(url_database_recipe)
	#TYPE
	recipe.push_back(itemData["type"]) #0

	recipe_type = recipe[0]

	match(recipe_type):#Shapless, Shaped or Smelting Recipe
		"crafting_shaped":
			#GROUP
			if itemData.has("group"):
				recipe.push_back(itemData["group"]) #1
				item_group = get_recipe_shaped()[arrayModifier+1]
			else:
				arrayModifier = -1
				item_group = "None"
			
			#GET PATERN
			var pattern = []
			pattern = get_recipe_shaped()[arrayModifier+2]
			
			#GET KEYS
			var keys = []
			var temp = []
			
			keys = get_recipe_shaped()[arrayModifier+3].keys()
			#Resize input_amount to fit all the diffrent materials in recipe.
			input_amount.resize(keys.size())
			input_item.resize(keys.size())

			#Break the pattern down in to a single letter array.
			for x in pattern.size():
				for y in pattern[x].length():
					temp.push_back(pattern[x][y])
					
			#How many of each material is in the pattern?
			for a in keys.size():
				for z in temp.size():
					input_amount[a] = temp.count(keys[a])
					
			#What are the input items?
			for a in keys.size():
				if get_recipe_shaped()[arrayModifier+3].values()[a].has("item"):
					input_item[a] = get_recipe_shaped()[arrayModifier+3].values()[a]["item"]
				elif get_recipe_shaped()[arrayModifier+3].values()[a].has("tag"):
					input_item[a] = get_recipe_shaped()[arrayModifier+3].values()[a]["tag"]
				#Create input item and amount string.
				inputString += String(input_amount[a])+" "+ String(input_item[a])+"\n"
				
			
			#RESULT / OUTPUT
			output_item = get_recipe_shaped()[arrayModifier+4][0]
			#RESULT / OUTPUT AMOUNT
			if output_amount != 1:#If the output amount is more then 1 then get how many.
				output_amount = get_recipe_shaped()[arrayModifier+4][1]
			else:#Othewise get output and set the output amount to 1.
				output_amount = 1
			
			
			#STRING OUTPUT
			recipe_output = "Type: "+String(recipe_type)+"\n"+"Group: "+String(item_group)+"\n\n"+"Input: "+String(inputString)+"\n"+"Output: "+"\n"+String(output_amount)+" "+String(output_item)
		
		"crafting_shapeless":
				#SHAPELESS RECIPES
				#GROUP
				if itemData.has("group"):
					recipe.push_back(itemData["group"]) #1
					item_group = get_recipe_shapeless()[arrayModifier+1]
				else:
					arrayModifier = -1
					item_group = "None"
					
				#INGREDIENTS / INPUT
				#GET INGREDIENTS
				var ingredients_list = []
				
				ingredients_list = get_recipe_shapeless()[arrayModifier+2]
				input_amount.resize(ingredients_list.size())
				input_item.resize(ingredients_list.size())
				print(ingredients_list)
				for a in ingredients_list.size():
					if ingredients_list[a].has("item"):
						input_item[a] = ingredients_list[a]["item"]
					elif ingredients_list[a].has("tag"):
						input_item[a] = ingredients_list[a]["tag"]
					#Create input item and amount strings
					inputString += "1 "+ String(input_item[a])+"\n"
					
				#RESULT / OUTPUT
				output_item = get_recipe_shapeless()[arrayModifier+3][0]
				#RESULT / OUTPUT AMOUNT
				if output_amount != 1:#If the output amount is more then 1 then get how many.
					output_amount = get_recipe_shapeless()[arrayModifier+3][1]
				else:#Othewise get output and set the output amount to 1.
					output_amount = 1
				#STRING OUTPUT
				recipe_output = "Type: "+String(recipe_type)+"\n"+"Group: "+String(item_group)+"\n\n"+"Input: "+String(inputString)+"\n"+"Output: "+"\n"+String(output_amount)+" "+String(output_item)

#Functions
func get_recipe_shapeless():
	#DOES RECIPE EXIST? If not then skip with a print message.
	if !itemData.has("result"):
		print ("This recipe does not exist!")
		return
	
	#INGREDIENTS / INPUT
	recipe.push_back(itemData["ingredients"]) #2

	#TAG
	if itemData["ingredients"][0].has("tag"):
		hasTag = true
	else:
		hasTag = false
	
	#RESULT / OUTPUT
	recipe.push_back(itemData["result"].values()) #3

	#RESULT / OUTPUT AMOUNT
	if itemData["result"].values().size()==1:
		output_amount = 1

	#FUNCTION RETURN
	return recipe
	
	
	
func get_recipe_shaped():
	
	#DOES RECIPE EXIST? If not then skip with a print message.
	if !itemData.has("result"):
		print ("This recipe does not exist!")
		return

	#INGREDIENTS / INPUT
	recipe.push_back(itemData["pattern"]) #2
	
	#KEYS
	recipe.push_back(itemData["key"]) #3
	
	#RESULT / OUTPUT
	recipe.push_back(itemData["result"].values()) #4

	#RESULT / OUTPUT AMOUNT
	if itemData["result"].values().size()==1:
		output_amount = 1

	#FUNCTION RETURN
	return recipe
	
	
	
	
	
	
	
	
	
	