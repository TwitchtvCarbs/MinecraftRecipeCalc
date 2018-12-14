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
	instancedOutputItem[id]._setAmount(amount * Global.outputMultiplyer)
	instancedOutputItem[id]._setModName(modname)

func _setInputInfo(id,name,amount,modname):
	instancedInputItems[id]._setName(name)
	instancedInputItems[id]._setAmount(amount * Global.outputMultiplyer)
	instancedInputItems[id]._setModName(modname)
	pass
	
func _updateGUIOutput(recipe):
	itemOutputData = Global_DataParser.load_data("res://Database//Recipe_Database.json")
	instancedOutputItem.push_back(menuItemScene.instance())
	$Margin/VBox/Items.add_child(instancedOutputItem[0])
	_setOutputInfo(0,itemOutputData[0]["output_name"],itemOutputData[0]["output_amount"],itemOutputData[0]["output_modname"])
	_updateGUIInputs()

func _updateGUIInputs():
	itemInputData = Global_DataParser.load_data("res://Database//Recipe_Database.json")
	var inputCount = 4
	for i in inputCount:
		instancedInputItems.push_back(menuItemScene.instance())
		if i == 0:
			continue
		$Margin/VBox/Items.add_child(instancedInputItems[i])
		_setInputInfo(i,String(itemInputData[0]["input_items"][i]),float(itemInputData[0]["input_amount"][i]),String(itemInputData[0]["input_modname"][i]))
	pass
