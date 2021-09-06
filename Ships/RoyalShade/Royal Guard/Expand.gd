extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var lifetime
var maxLifetime
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	maxLifetime = lifetime
	sprite = get_parent().get_node("Sprite")
	sprite.opacity = 0.0
	sprite.scale = Vector3(0, 0, 1)
	pass
func _process(delta):
	lifetime -= delta
	if(lifetime > 0):
		var amount = lifetime / maxLifetime
		sprite.opacity = amount
		sprite.scale = Vector3(1 - amount, 1 - amount, 1)
	else:
		get_parent().queue_free()
	pass
