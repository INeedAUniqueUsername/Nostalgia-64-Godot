extends Spatial

var particleScene = preload("res://Common/SpriteFadeParticle.tscn")
export(Texture) var texture
export(float) var particleLifetime
export(float) var apothem
export(float) var interval
export(float) var emitTime
var time = 0
func _ready():
	
	pass
#We emit particles around our own position
func _process(delta):
	emitTime -= delta
	
	#We're waiting to emit
	if(time > 0):
		time -= delta;
	elif(emitTime > 0):
		#We're ready to emit and we still have time left
		time = interval;
		var particle = particleScene.instance()
		#Particle spawns relative to our position
		particle.translate(Vector3(rand_range(-apothem, apothem), rand_range(-apothem, apothem), 0))
		particle.texture = texture
		particle.lifetime = particleLifetime
		particle.startOpacity = 1
		add_child(particle)
	elif(get_child_count() == 0):
		#We're done emitting and we're waiting for our children to expire
		queue_free()
		pass
		
	pass
