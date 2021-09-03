extends Node

var winLabel
var button
var shipSelect

func _ready():
	winLabel = get_node("WinLabel")
	button = get_node("Button")
	
	button.connect("pressed", self, "openShipSelect")
	
	winLabel.hide()
	button.hide()

func p1win():
	winLabel.set_text("PLAYER 1 WINS")
	showWin()
func p2win():
	winLabel.set_text("PLAYER 2 WINS")
	showWin()
func showWin():
	winLabel.show()
	button.show()

func openShipSelect():
	var world = get_parent()
	var root = world.get_parent()
	root.remove_child(world)
	root.add_child(shipSelect)
