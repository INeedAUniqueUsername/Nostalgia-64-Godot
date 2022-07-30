extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Config {
	ui, p1, p2
}
export(Config) var conf

signal cannot_fire
signal cannot_thrust

var FireLeft;
var FireRight;
var FireMiddle;
var ThrustLeft;
var ThrustRight;
var ThrustMiddle;
# Called when the node enters the scene tree for the first time.
func init():
	for segment in get_parent().get_children():
		for k in ["FireLeft", "FireMiddle", "FireRight", "ThrustLeft", "ThrustMiddle", "ThrustRight"]:
			var n = segment.get_node(k)
			if !n: continue
			set(k, n)
	for f in [FireLeft, FireMiddle, FireRight]:
		if(f == null):
			continue
		f.connect("tree_exited", self, "updateCanFire")
	for t in [ThrustLeft, ThrustMiddle, ThrustRight]:
		if(t == null):
			continue
		t.connect("tree_exited", self, "updateCanThrust")
func _ready():
	init()
func _process(delta):
	if(conf == Config.ui):
		controls("ui")
	elif(conf == Config.p1):
		controls("p1")
	elif(conf == Config.p2):
		controls("p2")
func controls(prefix):
	check(prefix + "_left", ThrustLeft)
	check(prefix + "_right", ThrustRight)
	check(prefix + "_up", ThrustMiddle)
	check(prefix + "_fire_left", FireLeft)
	check(prefix + "_fire_right", FireRight)
	check(prefix + "_fire_middle", FireMiddle)
func check(action, target):
	if(!is_instance_valid(target)):
		return
	if(Input.is_action_just_pressed(action)):
		target.onPressed()
	if(Input.is_action_just_released(action)):
		target.onReleased()
		
func updateCanFire():
	if(!canFire()):
		emit_signal("cannot_fire")
func updateCanThrust():
	if(!canThrust()):
		emit_signal("cannot_thrust")
func canFire():
	var left = (FireLeft != null && is_instance_valid(FireLeft) && FireLeft.is_inside_tree())
	var middle = (FireMiddle != null && is_instance_valid(FireMiddle) && FireMiddle.is_inside_tree())
	var right = (FireRight != null && is_instance_valid(FireRight) && FireRight.is_inside_tree())
	var result = left || middle || right
	return result
func canThrust():
	return (ThrustLeft != null && is_instance_valid(ThrustLeft)) || (ThrustMiddle != null && is_instance_valid(ThrustMiddle)) || (ThrustRight != null && is_instance_valid(ThrustRight))
