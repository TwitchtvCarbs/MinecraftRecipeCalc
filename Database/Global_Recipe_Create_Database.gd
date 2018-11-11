extends Node

var recipeToLoad = "iron_bars"

var url_database_recipe = "res://Recipes//1.13.2 JsonRecipes//"+String(recipeToLoad)+".json"

func _ready():
	print(url_database_recipe)

	var output_item = get_recipe("result")[0]
	var output_amount = get_recipe("result")[1]
	print("Output: "+String(output_amount)+" "+String(output_item))
	
	
func get_recipe(result):
	var itemData = {}
	itemData = Global_DataParser.load_data(url_database_recipe)
	
	if !itemData.has(String(result)):
		print ("This recipe does not exist!")
		return
		
	return itemData[String(result)].values()