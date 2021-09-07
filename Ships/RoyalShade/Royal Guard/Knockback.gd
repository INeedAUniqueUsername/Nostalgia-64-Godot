extends Node

export(float) var knockback

func _ready():
	get_parent().get_node("Projectile").connect("projectile_hit", self, "on_hit")
	get_parent().get_node("Projectile").connect("blast_hit", self, "on_hit")
	pass

func on_hit(other):
	var vel = get_parent().linear_velocity.normalized()
	other.apply_impulse(get_parent().transform.origin, vel * knockback)
