extends Sprite3D

export(float) var lifetime
export(float) var startOpacity

var lifeLeft

func _ready():
	lifeLeft = lifetime
	pass

func _process(delta):
	if(lifeLeft > 0):
		lifeLeft -= delta
		opacity = (lifeLeft / lifetime) * startOpacity
	pass
