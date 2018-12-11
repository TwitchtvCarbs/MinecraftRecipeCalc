extends Node
export (int) var maxItems
var menuItemScene = load("res://GUI/Menu_Required_Items/MenuItem.tscn")
var instancedOutputItem = []
var itemOutputData = []

var instancedInputItems = []
var itemInputData = []

func _ready():	
	pass
	
	
func _setOutputInfo(id,name,amount,modname):
	instancedOutputItem[id]._setName(name)
	instancedOutputItem[id]._setAmount(amount)
	instancedOutputItem[id]._setModName(modname)

func _setInputInfo(id,name,amount,modname):
	instancedInputItems[id]._setName(name)
	instancedInputItems[id]._setAmount(amount)
	instancedInputItems[id]._setModName(modname)
	pass
	
func _updateGUIOutput(recipe):
	itemOutputData = Global_DataParser.load_data("res://Database//Recipe_Database.json")
	instancedOutputItem.push_back(menuItemScene.instance())
	$Margin/VBox/Items.add_child(instancedOutputItem[0])
	_setOutputInfo(0,itemOutputData[0]["output_name"],itemOutputData[0]["output_amount"],itemOutputData[0]["output_modname"])

func _updateGUIInputs():
	
	pass
