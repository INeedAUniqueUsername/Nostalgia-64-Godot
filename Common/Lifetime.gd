extends Node

export(float) var lifetime

signal lifetime_expired

func _process(delta):
	if(lifetime > 0):
		lifetime -= delta
	else:
		emit_signal("lifetime_expired")
		get_parent().queue_free()
	pass
