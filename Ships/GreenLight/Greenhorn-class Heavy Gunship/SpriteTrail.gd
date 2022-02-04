extends Node

export(Texture) var texture
export(float) var spawnInterval = 1/30.0
export(float) var particleLifetime = 0.2
export(float) var startOpacity = 1.0
var spawnTime = 0

const particle = preload("res://Common/SpriteFadeParticle.tscn")

#We define particle positions on global space only

func _process(delta):
	if(spawnTime > 0):
		spawnTime -= delta
	else:
		spawnTime = spawnInterval
		var p = particle.instance()
		p.set_transform(get_parent().get_global_transform().orthonormalized())
		p.texture = texture
		p.startOpacity = 1.0
		p.lifetime = particleLifetime
		p.lifeLeft = p.lifetime
		p.startOpacity = startOpacity
		add_child(p)
