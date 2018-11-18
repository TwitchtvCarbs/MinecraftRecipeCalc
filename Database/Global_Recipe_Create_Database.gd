extends Node

var recipeToLoad = "detector_rail"

var url_database_recipe = "res://Recipes//1.13.2 JsonRecipes//"+String(recipeToLoad)+".json"
var recipe_output
var input_item
var input_amount
var output_item
var output_amount
var item_group
var recipe_type
var hasTag = false 
var hasGroup = false
var arrayModifier = 0 #Used when an recipe doesn't have a group and sets to one less then recipes with a group.





func _ready():

	#TYPE
	##recipe_type = get_recipe_shapeless()[0] #Shapless, Shaped or Smelting Recipe
	recipe_type = get_recipe_shaped()[0]
	#GROUP
	if hasGroup == true:
		##item_group = get_recipe_shapeless()[arrayModifier+1]
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
	var finalKey = []
	
	keys = get_recipe_shaped()[arrayModifier+3]
	#Resize finalkey to fit all the diffrent materials in recipe.
	finalKey.resize(keys.size())
	
	#Break the pattern down in to a single letter array.
	for x in pattern.size():
		for y in pattern[x].length():
			temp.push_back(pattern[x][y])
			
	#How many of each material is in the pattern?
	for a in keys.size():
		print("a")
		for z in temp.size():
			print("z")
			finalKey[a] = temp.count(keys[a])
	
	print("FINAL: "+String(finalKey))
	#INGREDIENTS / INPUT
	##if hasTag == true:#If the input item has a tag then use it if not use item.
		##input_item = get_recipe_shapeless()[arrayModifier+2][0]["tag"]
		##input_item = get_recipe_shaped()[arrayModifier+2][0]["tag"]
	##else:
		##input_item = get_recipe_shapeless()[arrayModifier+2][0]["item"]
		##input_item = get_recipe_shaped()[arrayModifier+2][0][0]["item"]

	#RESULT / OUTPUT
	##output_item = get_recipe_shapeless()[arrayModifier+3][0]
	output_item = get_recipe_shaped()[arrayModifier+3][0]
	
	#RESULT / OUTPUT AMOUNT
	if output_amount != 1:#If the output amount is more then 1 then get how many.
		##output_amount = get_recipe_shapeless()[arrayModifier+3][1]
		output_amount = get_recipe_shaped()[arrayModifier+3][1]
	else:#Othewise get output and set the output amount to 1.
		output_amount = 1
	
	
	#STRING OUTPUT
	recipe_output = "Type: "+String(recipe_type)+"\n"+"Group: "+String(item_group)+"\n"+"Input: "+String(input_amount)+" "+String(input_item) +"\n"+"Output: "+String(output_amount)+" "+String(output_item)

func get_recipe_shapeless():
	var itemData = {}#Create a dictionary for temp items recipe data
	var recipe = []
	itemData = Global_DataParser.load_data(url_database_recipe)
	
	#DOES RECIPE EXIST? If not then skip with a print message.
	if !itemData.has("result"):
		print ("This recipe does not exist!")
		return
		
	#TYPE
	recipe.push_back(itemData["type"]) #0

	#GROUP
	if itemData.has("group"):
		recipe.push_back(itemData["group"]) #1
		hasGroup = true
	else:
		hasGroup = false

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
	var itemData = {}#Create a dictionary for temp items recipe data
	var recipe = []
	itemData = Global_DataParser.load_data(url_database_recipe)
	
	#DOES RECIPE EXIST? If not then skip with a print message.
	if !itemData.has("result"):
		print ("This recipe does not exist!")
		return
		
	#TYPE
	recipe.push_back(itemData["type"]) #0

	#GROUP
	if itemData.has("group"):
		recipe.push_back(itemData["group"]) #1
		hasGroup = true
	else:
		hasGroup = false

	##print(itemData)

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
	recipe.push_back(itemData["key"].keys()) #3
	
	#RESULT / OUTPUT
	recipe.push_back(itemData["result"].values()) #4

	#RESULT / OUTPUT AMOUNT
	if itemData["result"].values().size()==1:
		output_amount = 1

	#FUNCTION RETURN
	return recipe
	
	
	
	
	
	
	
	
	
	