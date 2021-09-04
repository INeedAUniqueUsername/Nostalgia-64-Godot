extends Node

signal lifetime_expired
export(PackedScene) var fragment
export(int) var count
export(float) var angle
export(float) var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Lifetime").connect("lifetime_expired", self, "on_lifetime_expired")
	pass # Replace with function body.

func on_lifetime_expired():
	var p = get_parent()
	var pos = p.transform.origin
	var vel = p.linear_velocity
	var angle = atan2(vel.y, vel.x)
	for i in range(count):
		var f = fragment.instance()
		
		var a = floor((i + 1)/2) * angle
		if(i%2 == 1):
			a = -a
		
		f.transform.origin = (pos)
		var velAdded = Vector3(cos(a) * speed, sin(a) * speed, 0)
		f.linear_velocity = vel + velAdded
		f.get_node("Projectile").creator = get_parent().get_node("Projectile").creator
		get_parent().get_parent().add_child(f)
	pass
