extends Node

export(NodePath) var parentBody

func _ready():
	parentBody = get_node(parentBody)
	parentBody.connect("body_entered", self, "body_entered")
	pass
func body_entered(body):
	body.add_child(get_parent())
	pass