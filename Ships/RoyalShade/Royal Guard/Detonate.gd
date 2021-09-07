extends Node

export(PackedScene) var explosion
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Projectile").connect("projectile_hit", self, "on_projectile_hit")

func on_projectile_hit(body):
	var e = explosion.instance()
	e.transform.origin = get_parent().transform.origin
	e.get_node("Projectile").creator = get_parent().get_node("Projectile").creator
	get_parent().get_parent().add_child(e)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
