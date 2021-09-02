extends Node

export(NodePath) var target
export(String) var action
	
func _ready():
	var error = ""
	if(target):
		target = get_node(target)
	if(target == null):
		warn("target missing")
	if(!target.has_method("onPressed")):
		warn("target missing onPressed")
	if(!target.has_method("onReleased")):
		warn("target missing onReleased")
	if(!action):
		warn("action missing")
	pass

func _process(delta):
	if(!is_instance_valid(target)):
		return
	if(Input.is_action_just_pressed(action)):
		print("target: " + target.name)
		target.onPressed()
	elif(Input.is_action_just_released(action)):
		print("target: " + target.name)
		target.onReleased()

export(bool) var printErrors = false;
export(bool) var printWarnings = true;
export(bool) var printInfo = true;
func warn(message):
	if(printErrors):
		printerr("" + get_path() + ">" + message)
	elif(printWarnings): print("" + get_path() + ">" + message)
	pass
func info(message):
	if(printInfo): print("" + get_path() + ">" + message)
	pass
