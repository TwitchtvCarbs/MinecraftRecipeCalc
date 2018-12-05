extends Node
var recipeToLoad = "stone_slab"
var recipeFolder = "res://Recipes//1.13.2 JsonRecipes//"

var url_database_recipe = recipeFolder+String(recipeToLoad)+".json"
var recipe_database = "res://Database//Recipe_Database.json"
var recipe_type
var recipe_output
var input_item = []
var input_amount = []
var cook_time
var smelt_xp
var inputString = "\n"
var output_item
var output_amount
var item_group
var hasTag
var arrayModifier = 0 #Used when an recipe doesn't have a group and sets to one less then recipes with a group.
var itemData = {}#Create a dictionary for temp items recipe data
var recipe = []
var database = []
var modName
var recipeCount =_getAllRecipes()[0]
var loadedRecipes = 0

func init(loadRecipe):
	recipeToLoad = loadRecipe
	url_database_recipe = "res://Recipes//1.13.2 JsonRecipes//"+String(recipeToLoad)+".json"
	recipe_type = null
	recipe_output = null
	input_item = []
	input_amount = []
	cook_time = null
	smelt_xp = null
	inputString = "\n"
	output_item = null
	output_amount = null
	item_group = null
	hasTag = null
	arrayModifier = 0 #Used when an recipe doesn't have a group and sets to one less then recipes with a group.
	itemData = {}#Create a dictionary for temp items recipe data
	recipe = []
	var modName
	
func _ready():
	#load in all recipes
	for a in _getAllRecipes()[0]:
		init(String(_getAllRecipes()[1][a]))
		_run()
		loadedRecipes = loadedRecipes+1
		
func _run():
	#DOES RECIPE EXIST? If not then skip with a print message.
	var file2check = File.new()
	if !file2check.file_exists(url_database_recipe):
		recipe_output="This recipe does not exist!"
		print ("This recipe does not exist!")
		return
	#Load data from the recipe file
	itemData = Global_DataParser.load_data(url_database_recipe)
	
	#TYPE
	recipe.push_back(itemData["type"]) #0
	recipe_type = recipe[0]
	
	#GROUP
	if itemData.has("group"):
		recipe.push_back(itemData["group"]) #1
		if recipe_type == "crafting_shapeless":
			item_group = get_recipe_shapeless()[arrayModifier+1]
		elif recipe_type =="crafting_shaped":
			item_group = get_recipe_shaped()[arrayModifier+1]
	else:
		arrayModifier = -1
		item_group = "None"

	match(recipe_type):#Shapless, Shaped or Smelting Recipe
		"crafting_shaped":			
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
			
			
			modName = String(_getModName(output_item)[0])
			output_item = String(_getModName(output_item)[1])
			
			
			#STRING OUTPUT
			recipe_output =  "Type: "+String(recipe_type)+"\n"
			recipe_output += "Group: "+String(item_group)+"\n\n"
			recipe_output += "Input: "+"\n"+String(inputString)+"\n"
			recipe_output += "Output: "+"\n"+String(output_amount)+" "+String(output_item)+"\n\n"
			recipe_output += "Orgin: "+"\n"+String(modName)
			
			
		"crafting_shapeless":
				#INGREDIENTS / INPUT
				#GET INGREDIENTS
				var ingredients_list = []
				
				ingredients_list = get_recipe_shapeless()[arrayModifier+2]
				for a in ingredients_list.size():
					if ingredients_list[a].has("item"):
						#Does input_item already have this material in its array?
						if input_item.has(ingredients_list[a]["item"]): 
							continue #if so then go to the next material
						else:
							var count = 0
							for b in ingredients_list.size():
								#Check if the material is a dictionary
								if typeof(ingredients_list[b]) != TYPE_DICTIONARY:
									#for x in ingredients_list[b].size():
										#input_item.append(ingredients_list[b][x]["item"])
										#input_amount.append(count)
									continue #if so go to the next material
								if(ingredients_list[a]["item"] == ingredients_list[b]["item"]):
									count = count + 1
							input_item.append(ingredients_list[a]["item"]) #add material to array
							input_amount.append(count) #with it's amount
							
					elif ingredients_list[a].has("tag"):
						if input_item.has(ingredients_list[a]["tag"]):
							continue
						else:
							var count = 0
							for b in ingredients_list.size():
								#Check if the material is a dictionary
								if typeof(ingredients_list[b]) != TYPE_DICTIONARY:
									continue #if so go to the next material
								if (ingredients_list[a]["tag"] == ingredients_list[b]["tag"]):
									count = count + 1
							input_item.append(ingredients_list[a]["tag"])
							input_amount.append(count)
					#Create input item and amount strings
				for c in input_item.size():
					inputString += String(input_amount[c])+" "+String(input_item[c])+"\n"
					
				#RESULT / OUTPUT
				output_item = get_recipe_shapeless()[arrayModifier+3][0]
				#RESULT / OUTPUT AMOUNT
				if output_amount != 1:#If the output amount is more then 1 then get how many.
					output_amount = get_recipe_shapeless()[arrayModifier+3][1]
				else:#Othewise get output and set the output amount to 1.
					output_amount = 1
					
				modName = String(_getModName(output_item)[0])
				output_item = String(_getModName(output_item)[1])
				#STRING OUTPUT
				recipe_output =  "Type: "+String(recipe_type)+"\n"
				recipe_output += "Group: "+String(item_group)+"\n\n"
				recipe_output += "Input: "+String(inputString)+"\n"
				recipe_output += "Output: "+"\n"+String(output_amount)+" "+String(output_item)+"\n\n"
				recipe_output += "Orgin: "+"\n"+String(modName)


		"smelting":
			var ingredients_list = []
			ingredients_list = get_recipe_smelting()[arrayModifier+2]
			if ingredients_list.size()>1:
				print("This is an or recipe with multiple options for inputs.")
			
			output_item = get_recipe_smelting()[arrayModifier+3]
			for a in ingredients_list.size():
				if ingredients_list.has("item"):
					input_item.append(ingredients_list["item"])
				elif ingredients_list.has("tag"):
					input_item.append(ingredients_list["tag"])
					#Create input item and amount strings
				inputString += String(1)+" "+String(input_item[a])+" or"+"\n"
			
			cook_time = get_recipe_smelting()[arrayModifier+4]
			smelt_xp = get_recipe_smelting()[arrayModifier+5]
			
			
			modName = String(_getModName(output_item)[0])
			output_item = String(_getModName(output_item)[1])
			
			recipe_output =  "Type: "+String(recipe_type)+"\n"
			recipe_output += "Group: "+String(item_group)+"\n\n"
			recipe_output += "Input: "+"\n"+String(inputString)+"\n"
			recipe_output += "Output: "+"\n"+String(output_amount)+" "+String(output_item)+"\n"
			recipe_output += "Cooktime: "+String(cook_time / 20)+" secs ( "+String(cook_time)+" ) ticks"+"\n"
			recipe_output += "Experience: "+String(smelt_xp)+"\n\n"
			recipe_output += "Orgin: "+"\n"+String(modName)
	_addRecipeToDatabase()
#Functions
func get_recipe_shapeless():
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
	
func get_recipe_smelting():
	#INGREDIENTS / INPUT
	recipe.push_back(itemData["ingredient"]) #2

	#TAG
	if itemData["ingredient"].has("tag"):
		hasTag = true
	else:
		hasTag = false
	
	#RESULT / OUTPUT
	recipe.push_back(itemData["result"]) #3


	#COOK TIME
	recipe.push_back(itemData["cookingtime"])#4
	
	#SMELT XP
	if itemData.has("experience"):
		recipe.push_back(itemData["experience"]) #5
	
	#RESULT / OUTPUT AMOUNT
	#if !itemData["result"][0].has["count"]:
	output_amount = 1

	#FUNCTION RETURN
	return recipe
	
	
func _getModName(item):
	var text = []
	var index = String(item).find(":")
	if index != -1:
		text.push_front(item.right(index+1).replace("_"," "))
		text.push_front(item.left(index).replace("_"," "))
	return text
	
func _addRecipeToDatabase():
	var newDict = {"output_name":output_item,
				   "output_amount":output_amount,
				   "input_items":input_item,
				   "input_amount":input_amount,
				   "modname":modName}
	database.push_back(newDict)
	Global_DataParser.write_data(recipe_database,database)
	
func _getAllRecipes():
	var files = []
	var totalRecipes = [null,null]
	var dir = Directory.new()
	dir.open(recipeFolder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file =="":
			break
		elif not file.begins_with("."):
			var index = String(file).find(".")
			
			files.append(String(file).left(index))
			
	dir.list_dir_end()
	totalRecipes.push_front(files)
	totalRecipes.push_front(files.size())
	return totalRecipes
	
	
	
	
	
	