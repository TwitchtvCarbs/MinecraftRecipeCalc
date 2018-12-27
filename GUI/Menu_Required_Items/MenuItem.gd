extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _setName(name):
	$HBox/VBox/ItemName.text = name
	$HBox/ItemIconBG/ItemIcon.texture = load("res://GUI//Menu_Images//Items//"+String(name).replace(" ","_")+".png")
	
func _setAmount(amount):
	$HBox/ItemIconBG/ItemIconNumber/IconNumber.text = String(amount)

func _setModName(modname):
	$HBox/VBox/ModName.text = modname
	pass