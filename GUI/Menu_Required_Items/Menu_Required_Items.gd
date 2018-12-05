extends Node
export (int) var maxItems
var menuItemScene
var instancedItem = []
var itemData = []

func _ready():	
	pass
	
	
func _setOutputInfo(id,name,amount,modname):
	instancedItem[id]._setName(name)
	instancedItem[id]._setAmount(amount)
	instancedItem[id]._setModName(modname)
	
func _updateGUI():
	menuItemScene = load("res://GUI/Menu_Required_Items/MenuItem.tscn")
	itemData = Global_DataParser.load_data("res://Database//Recipe_Database.json")
	maxItems = itemData.size()
	print(maxItems)
	for a in maxItems:
		instancedItem.push_back(menuItemScene.instance())
		$Margin/VBox/Items.add_child(instancedItem[a])
		print(itemData)
		_setOutputInfo(a,itemData[a]["output_name"],itemData[a]["output_amount"],itemData[a]["modname"])