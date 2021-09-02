extends Node


export(PackedScene) var trail
export(float) var interval

var time = 0

func _process(delta):
	if(time > 0):
		time -= delta
	else:
		time = interval
		var particle = trail.instance()
		particle.set_transform(get_parent().get_global_transform().orthonormalized())
		add_child(particle)
	pass
