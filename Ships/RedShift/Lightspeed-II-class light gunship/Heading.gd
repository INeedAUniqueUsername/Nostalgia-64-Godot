extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pip = load("res://Pip.tscn")
var pips
var length

# Called when the node enters the scene tree for the first time.
func _ready():
	pips = []
	length = 0
	for i in range(32):
		var p = pip.instance()
		add_child(p)
		pips.push_back(p)
		
func _process(delta):
	if(length < 32):
		length += delta * 1.5
	for i in range(length):
		pips[i].transform.origin = Vector3(i * 0.75, 0, 0)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
