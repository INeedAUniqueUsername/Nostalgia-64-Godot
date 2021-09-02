extends Node

export(Texture) var texture
export(float) var spawnInterval = 1/30.0
export(float) var particleLifetime = 0.2
export(float) var startOpacity = 1.0
var spawnTime = 0

#We define particle positions on global space only

func _process(delta):
	if(spawnTime > 0):
		spawnTime -= delta
	else:
		spawnTime = spawnInterval
		var particle = preload("res://Common/SpriteFadeParticle.tscn").instance()
		particle.set_transform(get_parent().get_global_transform().orthonormalized())
		particle.texture = texture
		particle.startOpacity = 1.0
		particle.lifetime = particleLifetime
		particle.lifeLeft = particle.lifetime
		particle.startOpacity = startOpacity
		add_child(particle)
	pass
