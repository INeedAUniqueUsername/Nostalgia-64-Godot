extends Node

export(float) var strength
var creator;

func _ready():
	get_parent().connect("body_entered", self, "body_entered")
	pass
func body_entered(body):
	
	var b = body;
	if(b != null):
		if(b == creator):
			return;
		b = b.get_parent();
	
	var local = get_parent().get_global_transform().orthonormalized().origin - body.get_global_transform().orthonormalized().origin;
	var angle = get_parent().rotation.z + PI;
	body.apply_impulse(local, Vector3(strength * cos(angle), strength * sin(angle), 0))
	pass
