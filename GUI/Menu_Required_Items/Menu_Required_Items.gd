extends Node
export (int) var maxItems
var menuItemScene
var instancedItem = []

func _ready():
	menuItemScene = load("res://GUI/Menu_Required_Items/MenuItem.tscn")
	for a in maxItems:
		instancedItem.push_back(menuItemScene.instance())
		$Margin/VBox/Items.add_child(instancedItem[a])
		
	_setInfo(0,"diamond_block",5)
	_setInfo(1,"gold_axe",1)
	_setInfo(2,"oak_log",10)
	
func _setInfo(id,name,amount):
	instancedItem[id]._setName(name)
	instancedItem[id]._setAmount(amount)