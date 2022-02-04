extends Node
# This weapon takes an active shield segmen and launches it as a projectile
var active = false
func onPressed():
	active = true
func onReleased():
	active = false;
func _ready():
	pass
func _process(delta):
	pass
export(bool) var printErrors = false;
export(bool) var printWarnings = true;
export(bool) var printInfo = true;
func warn(message):
	if(printErrors):
		printerr("" + get_path() + ">" + message)
	elif(printWarnings): print("" + get_path() + ">" + message)
func info(message):
	if(printInfo): print("" + get_path() + ">" + message)
