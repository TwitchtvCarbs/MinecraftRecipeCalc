extends Node

var recipeToLoad = "flint_and_steel"

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




func _ready():
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
			print("Pattern: "+String(pattern))
			
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
					
			#What are the input items?		###*#*#*#*#### This isnt working yet!
			for a in keys.size():
				input_item[a] = get_recipe_shaped()[arrayModifier+3].values()[a]
				inputString += String(input_amount[a])+" "+ String(input_item[a])+"\n"
				#Create input item and amount string.
			
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
				if hasTag == true:#If the input item has a tag then use it if not use item.
					input_item = get_recipe_shapeless()[arrayModifier+2][0]["tag"]	
				else:
					input_item = get_recipe_shapeless()[arrayModifier+2][0]["item"]
					
				#RESULT / OUTPUT
				output_item = get_recipe_shapeless()[arrayModifier+3][0]
				#RESULT / OUTPUT AMOUNT
				if output_amount != 1:#If the output amount is more then 1 then get how many.
					output_amount = get_recipe_shapeless()[arrayModifier+3][1]
				else:#Othewise get output and set the output amount to 1.
					output_amount = 1
				#STRING OUTPUT
				recipe_output = "Type: "+String(recipe_type)+"\n"+"Group: "+String(item_group)+"\n"+"Input: "+String(input_amount)+" "+String(input_item) +"\n"+"Output: "+String(output_amount)+" "+String(output_item)


#Functions


func get_recipe_shapeless():
	#DOES RECIPE EXIST? If not then skip with a print message.
	if !itemData.has("result"):
		print ("This recipe does not exist!")
		return
	
	#INGREDIENTS / INPUT
	recipe.push_back(itemData["ingredients"]) #2

	#INGREDIENTS / INPUT AMOUNT
	if itemData["ingredients"].size()<=1:
		input_amount = 1
	else:
		input_amount = 0

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

	#INGREDIENTS / INPUT AMOUNT
	#for x in [itemData["pattern"].size()]:
	#	print("This is a line in the recipe.")
	#itemData["pattern"].size()<=1:
	
	#TAG
	#if itemData["ingredients"][0].has("tag"):
	#	hasTag = true
	#else:
	#	hasTag = false
	
	#KEYS
	recipe.push_back(itemData["key"]) #3
	
	#RESULT / OUTPUT
	recipe.push_back(itemData["result"].values()) #4

	#RESULT / OUTPUT AMOUNT
	if itemData["result"].values().size()==1:
		output_amount = 1

	#FUNCTION RETURN
	return recipe
	
	
	
	
	
	
	
	
	
	