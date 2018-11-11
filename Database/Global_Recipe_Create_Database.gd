extends Node

var recipeToLoad = "acacia_planks"

var url_database_recipe = "res://Recipes//1.13.2 JsonRecipes//"+String(recipeToLoad)+".json"
var recipe_output = "null"
var input_item = null
var input_amount = 0
var output_item = null
var output_amount = 0
var item_group = null
var hasTag = false
var hasGroup = false


func _ready():
	print(url_database_recipe)
	get_recipe()
	if hasTag == true:
		input_item = get_recipe()[1][0]["tag"]
	else:
		input_item = get_recipe()[1][0]["item"]
		
	output_item = get_recipe()[0][0]
	
	
	if output_amount != 1:
		output_amount = get_recipe()[0][1]
	else:
		output_amount = get_recipe()[0]
	
	var item_type = get_recipe()[2]
	if hasGroup == true:
		item_group = get_recipe()[3]
	else:
		item_group = "None"
	
	recipe_output = "Input: "+String(input_amount)+" "+String(input_item) +"\n"+"Output: "+String(output_amount)+" "+String(output_item)+"\n"+String("Type: "+String(item_type)+"\n"+"Group: "+String(item_group))

func get_recipe():
	var itemData = {}
	var recipe = []
	itemData = Global_DataParser.load_data(url_database_recipe)
	
	if !itemData.has("result"):
		print ("This recipe does not exist!")
		return
		
	if itemData["ingredients"][0].has("tag"):
		hasTag = true
		
	recipe.append(itemData["result"].values())
	recipe.append(itemData["ingredients"])
	
	
	if itemData["ingredients"].size()<=1:
		input_amount = 1
	else:
		input_amount = 0
	recipe.append(itemData["type"])
	
	if itemData["result"].values().size()==1:
		output_amount = 1

	if itemData.has("group"):
		recipe.append(itemData["group"])
	else:
		hasGroup = false
	return recipe
	
	
	
	
	
	
	
	
	
	