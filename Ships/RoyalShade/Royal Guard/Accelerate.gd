extends Node


export(float) var acceleration

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var angle = get_parent().rotation.z
	get_parent().linear_velocity += Vector3(cos(angle) * acceleration, sin(angle) * acceleration, 0)
