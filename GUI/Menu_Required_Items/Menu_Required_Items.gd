extends Node
export (int) var maxItems
var menuItemScene
var instancedItem = []
var itemData = []

func _ready():
	menuItemScene = load("res://GUI/Menu_Required_Items/MenuItem.tscn")
	itemData.resize(maxItems)
	for a in maxItems:
		instancedItem.push_back(menuItemScene.instance())
		$Margin/VBox/Items.add_child(instancedItem[a])
		itemData = Global_DataParser.load_data("res://Database//Recipe_Database.json")
		print(itemData)
		_setInfo(a,itemData[a]["output_name"],itemData[a]["output_amount"])
	
	
func _setInfo(id,name,amount):
	instancedItem[id]._setName(name)
	instancedItem[id]._setAmount(amount)