extends Node


func _ready():
	var outputMultiplier = $VBox/HBox/outputMutiplier
	pass


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
	pass # replace with function body


func _on_OptionButton_item_selected(ID):
	var recipeString = $VBox/OptionButton.get_item_text(ID)
	_getRecipeInfo(recipeString)
	pass # replace with function body
	
	
func _getRecipeInfo(recipe):
	#Global_Recipe_Create_Database.init(recipe)
	#Global_Recipe_Create_Database._run()
	#$VBox/debugPrintout.text = Global_Recipe_Create_Database.recipe_output
	$VBox/HBox/LineEdit.text=""
	$VBox/Menu_Required_Items._updateGUIInputs(recipe.replace("_"," "))




func _on_outputMutiplier_value_changed(value):
	Global.outputMultiplyer = floor(value)
	pass # replace with function body
