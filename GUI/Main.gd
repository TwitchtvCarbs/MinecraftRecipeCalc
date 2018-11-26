extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_LineEdit_text_entered(new_text):
	_getRecipeInfo(new_text)
	$VBox/OptionButton.add_item(new_text,$VBox/OptionButton.get_item_count()+1)

	pass # replace with function body


func _on_OptionButton_item_selected(ID):
	var recipeString = $VBox/OptionButton.get_item_text(ID)
	_getRecipeInfo(recipeString)
	pass # replace with function body
	
	
func _getRecipeInfo(recipe):
	Global_Recipe_Create_Database.init(recipe)
	Global_Recipe_Create_Database._run()
	$VBox/Label.text = Global_Recipe_Create_Database.recipe_output
