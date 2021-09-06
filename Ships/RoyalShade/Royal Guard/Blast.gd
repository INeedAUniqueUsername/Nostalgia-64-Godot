extends Node

export(NodePath) var creator
export(int) var damage

signal blast_hit

func _ready():
	if(creator is NodePath):
		creator = get_node(creator)
	get_parent().connect("body_entered", self, "body_entered")
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
	
	emit_signal("blast_hit")
	pass
