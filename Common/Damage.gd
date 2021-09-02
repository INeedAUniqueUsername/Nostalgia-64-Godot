extends Node
func _ready():
	get_parent().connect("body_entered", self, "body_entered")
	pass
func body_entered(body):
	print("damage")
	pass