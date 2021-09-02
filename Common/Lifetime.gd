extends Node

export(float) var lifetime

func _process(delta):
	if(lifetime > 0):
		lifetime -= delta
	else:
		get_parent().queue_free()
	pass
