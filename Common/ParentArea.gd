extends Node

func _ready():
	connect("body_entered", self, "body_entered")
	pass

func body_entered(body):
	get_parent().emit_signal("body_entered", body)
	pass
