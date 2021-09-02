extends RigidBody

export(NodePath) var area

func _ready():
	area = get_node(area)
	pass
func add_collision_exception_with(other):
	pass
