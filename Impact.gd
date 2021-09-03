extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("body_entered", self, "on_body_entered");

func on_body_entered(other):
	if(other.get_node("HP")):
		other.damage(20)
		pass

func _process(delta):
	pass
