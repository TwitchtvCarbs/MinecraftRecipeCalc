extends Node
var lastRecipe


func _on_LineEdit_text_entered(new_text):
	#var recentCount = $VBox/HBox/OptionButton.get_item_count()
	var tempText = new_text.replace(" ","_")
	_getRecipeInfo(tempText.to_lower())
	if Global_Recipe_Create_Database.recipe_output != "This recipe does not exist!":
		#if recentCount !=0:
			#for i in recentCount:
				#if $VBox/OptionButton.get_item_text(i) != new_text or $VBox/RecentRecipeBox/OptionButton.get_item_text(0) !=tempText:
					#$VBox/OptionButton.add_item(tempText.to_lower())
		#else:
			#if $VBox/OptionButton.get_item_text(0) != new_text or $VBox/RecentRecipeBox/OptionButton.get_item_text(0) !=tempText:
				$VBox/OptionButton.add_item(tempText.to_lower())
				lastRecipe = tempText.to_lower()


func _on_OptionButton_item_selected(ID):
	var recipeString = $VBox/OptionButton.get_item_text(ID)
	_getRecipeInfo(recipeString)
	lastRecipe = recipeString
	
	
func _getRecipeInfo(recipe):
	#Global_Recipe_Create_Database.init(recipe)
	#Global_Recipe_Create_Database._run()
	#$VBox/debugPrintout.text = Global_Recipe_Create_Database.recipe_output
	$VBox/HBox/LineEdit.text=""
	$VBox/Menu_Required_Items._updateGUIOutput(recipe.replace("_"," "))




func _on_outputMutiplier_value_changed(value):
	Global.outputMultiplyer = floor(value)
	if lastRecipe != null:
		_getRecipeInfo(lastRecipe)


func _on_LoadMCRecipes_pressed():
	Global_Recipe_Create_Database._loadAllRecipes()



func _on_AddRecipesToRecent_pressed():
	if $VBox/OptionButton.get_item_count() == 0:
		for i in Global_Recipe_Create_Database.recipeCount:
			$VBox/OptionButton.add_item(Global_Recipe_Create_Database._getAllRecipes()[1][i])
		$VBox/Buttons/RecipeCount.text = "Loaded Recipes: "+String(Global_Recipe_Create_Database.loadedRecipes)


func _on_ClearRecent_pressed():
	$VBox/OptionButton.clear()
	pass # replace with function body
