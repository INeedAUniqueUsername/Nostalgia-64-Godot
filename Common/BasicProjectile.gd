extends Node

export(NodePath) var creator
export(int) var damage
export(NodePath) var projectileParticles
export(PackedScene) var hitEffect


func _ready():
	get_parent().connect("body_entered", self, "body_entered")
	if(projectileParticles): projectileParticles = get_node(projectileParticles)
	pass
func body_entered(body):
	
	if(body == creator):
		return
	
	#We transfer our existing particles and hit effect to an empty node parented to the hit object so that their position is independent of the body
	
	print("body: " + body.name)
	print("creator: " + creator.name)
	
	var p = body;
	while p != null:
		print("p: " + p.name);
		if(p == creator):
			return
		p = p.get_parent();
		
	p = body;
	while(p != null):
		var hp = p.get_node("HP")
		if(hp != null):
			hp.damage(damage)
			break
		else:
			p = p.get_parent()
	
	if(projectileParticles):
		
		var empty = Node.new()
		body.add_child(empty)
		#Transfer all our globally-defined particles to the new body
		for particle in projectileParticles.get_children():
			#We need to deparent our particles so that they don't get destroyed with the projectile
			projectileParticles.remove_child(particle)
			empty.add_child(particle)
			
			print("Particle transferred")
		
		if(hitEffect):
			var hit = hitEffect.instance()
			hit.set_transform(get_parent().get_global_transform().orthonormalized())
			empty.add_child(hit)
		
	get_parent().queue_free()
	pass
