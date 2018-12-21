extends Node
export (int) var maxItems

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
	for x in $Margin/VBox/Items.get_child_count():
		#if x == 0:
			#continue
		$Margin/VBox/Items.get_child(x).queue_free()
		instancedInputItems = []
		instancedOutputItem = []
	itemOutputData = Global_DataParser.load_data("res://Database//Recipe_Database.json")
	for a in Global_Recipe_Create_Database.recipeCount:
		if itemOutputData[a-1]["output_name"] == recipe:
			var outputItems
			var outputAmounts
			var outputModNames
			var menuItemScene = load("res://GUI/Menu_Required_Items/MenuItem.tscn").instance()
			instancedOutputItem.push_back(menuItemScene)
			$Margin/VBox/Items.add_child(instancedOutputItem[0])
			outputItems = itemOutputData[a-1]["output_name"]
			outputAmounts = itemOutputData[a-1]["output_amount"]
			outputModNames = itemOutputData[a-1]["output_modname"]
			_setOutputInfo(0,outputItems,outputAmounts,outputModNames)
			_updateGUIInputs(recipe)
			break
		else:
			continue
			print("recipe not found")

func _updateGUIInputs(recipe):
	itemInputData = Global_DataParser.load_data("res://Database//Recipe_Database.json")
	for a in Global_Recipe_Create_Database.recipeCount:
		if itemInputData[a-1]["output_name"] == recipe:
			var inputCount = itemInputData[a-1]["input_items"].size()
			var inputItems = itemInputData[a-1]["input_items"]
			var inputAmounts = itemInputData[a-1]["input_amount"]
			var inputModNames = itemInputData[a-1]["input_modname"]
			for i in inputCount:
				var menuItemScene = load("res://GUI/Menu_Required_Items/MenuItem.tscn").instance()
				instancedInputItems.push_back(menuItemScene)
				$Margin/VBox/Items.add_child(instancedInputItems[i],true)
				inputItems    = String(itemInputData[a-1]["input_items"][i])
				if (itemInputData[a-1]["input_amount"].empty()):
					inputAmounts = 1.0
				else:
					inputAmounts  =  float(itemInputData[a-1]["input_amount"][i])
				inputModNames = String(itemInputData[a-1]["input_modname"][i])
				_setInputInfo(i,inputItems,inputAmounts,inputModNames)
			break
		else:
			continue
			print("recipe not found")
	pass
