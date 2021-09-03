extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Config {
	ui, p1, p2
}
export(Config) var conf

var fireLeft;
var fireRight;
var fireMiddle;
var thrustLeft;
var thrustRight;
var thrustMiddle;

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_parent().get_children():
		for node in child.get_children():
			var n = node.name;
			if(n == "FireLeft"):
				fireLeft = node;
			if(n == "FireRight"):
				fireRight = node;
			if(n == "FireMiddle"):
				fireMiddle = node;
			if(n == "ThrustLeft"):
				thrustLeft = node;
			if(n == "ThrustRight"):
				thrustRight = node;
			if(n == "ThrustMiddle"):
				thrustMiddle = node;
func _process(delta):
	if(conf == Config.ui):
		controls("ui")
	elif(conf == Config.p1):
		controls("p1")
	elif(conf == Config.p2):
		controls("p2")
	
func controls(prefix):
	check(prefix + "_left", thrustLeft)
	check(prefix + "_right", thrustRight)
	check(prefix + "_up", thrustMiddle)
	check(prefix + "_fire_left", fireLeft)
	check(prefix + "_fire_right", fireRight)
	check(prefix + "_fire_middle", fireMiddle)
			
func check(action, target):
	if(!is_instance_valid(target)):
		return
	if(Input.is_action_just_pressed(action)):
		target.onPressed()
	if(Input.is_action_just_released(action)):
		target.onReleased()
		
