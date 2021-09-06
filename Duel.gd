extends Node

var p1
var p2

var winLabel
var button
var shipSelect

func _ready():
	
	p1.connect("tree_exited", self, "destroyed")
	p2.connect("tree_exited", self, "destroyed")
	
	
	p1.get_node("Controls").connect("cannot_fire", self, "disarmed")
	p2.get_node("Controls").connect("cannot_fire", self, "disarmed")
	
	winLabel = get_node("WinLabel")
	button = get_node("Button")
	
	button.connect("pressed", self, "openShipSelect")
	
	winLabel.hide()
	button.hide()
	
var time = 0
var passed = 0
func _process(delta):
	
	if over:
		return
	time += delta
	passed += delta
	if(time > 1):
		time = 0
		if ((p1.transform.origin - p2.transform.origin).length() > 50):
			stalemate()
		if passed > 120:
			stalemate()

func destroyed():
	if is_instance_valid(p1):
		showResult("DESTROYED!\nPLAYER 1 WINS")
	elif is_instance_valid(p2):
		showResult("DESTROYED!\nPLAYER 2 WINS")
func disarmed():
	if is_instance_valid(p1) && is_instance_valid(p2):
		if p1.get_node("Controls").canFire():
			showResult("DISARMED!\nPLAYER 1 WINS")
		elif p2.get_node("Controls").canFire():
			showResult("DISARMED!\nPLAYER 2 WINS")
		
func stalemate():
	showResult("STALEMATE!\nNOBODY WINS")

var over = false
func showResult(text):
	over = true
	winLabel.set_text(text)
	winLabel.show()
	button.show()

func openShipSelect():
	var world = get_parent()
	var root = world.get_parent()
	root.remove_child(world)
	root.add_child(shipSelect)
