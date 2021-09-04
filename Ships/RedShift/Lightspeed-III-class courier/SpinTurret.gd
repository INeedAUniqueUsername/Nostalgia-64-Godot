extends Node

export(float) var turnRate
var turret

var active

func onPressed():
	active = true
func onReleased():
	active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	turret = get_parent()

func _process(delta):
	if active:
		turret = get_parent()
		var rd = turret.rotation_degrees
		turret.set_rotation_degrees(Vector3(rd.x, rd.y, rd.z + turnRate))
