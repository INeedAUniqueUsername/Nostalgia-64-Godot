extends Node

var p1
var p2

var winLabel
var button
var shipSelect

func _ready():
	
	p1.connect("tree_exited", self, "p2win")
	p2.connect("tree_exited", self, "p1win")
	
	
	p1.get_node("Controls").connect("cannot_fire", self, "p2winDisarm")
	p2.get_node("Controls").connect("cannot_fire", self, "p1winDisarm")
	
	winLabel = get_node("WinLabel")
	button = get_node("Button")
	
	button.connect("pressed", self, "openShipSelect")
	
	winLabel.hide()
	button.hide()



func p1win():
	winLabel.set_text("DESTROYED!\nPLAYER 1 WINS")
	showWin()
func p2win():
	winLabel.set_text("DESTROYED!\nPLAYER 2 WINS")
	showWin()

func p1winDisarm():
	winLabel.set_text("DISARMED!\nPLAYER 1 WINS")
	showWin()
func p2winDisarm():
	winLabel.set_text("DISARMED!\nPLAYER 2 WINS")
	showWin()

	
func showWin():
	winLabel.show()
	button.show()

func openShipSelect():
	var world = get_parent()
	var root = world.get_parent()
	root.remove_child(world)
	root.add_child(shipSelect)
