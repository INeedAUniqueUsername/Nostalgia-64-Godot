extends Node

export(Array, NodePath) var parts

func _ready():
	var parent = get_parent()
	for p in parts:
		var j = HingeJoint.new()
		j.set_exclude_nodes_from_collision(true)
		j.set_node_a(get_path_to(get_parent()))
		j.set_node_b(p)
		j.set_flag(HingeJoint.FLAG_USE_LIMIT, true)
		j.set_param(HingeJoint.PARAM_BIAS, 1)
		j.set_param(HingeJoint.PARAM_LIMIT_BIAS, 1)
		j.set_param(HingeJoint.PARAM_LIMIT_LOWER, 0)
		j.set_param(HingeJoint.PARAM_LIMIT_UPPER, 0)
		j.set_param(HingeJoint.PARAM_LIMIT_RELAXATION, 0)
		j.set_param(HingeJoint.PARAM_LIMIT_SOFTNESS, 0)
		parent.call_deferred("add_child", j)
		var tr = j.get_global_transform()
		tr.origin = get_node(p).get_global_transform().origin
		j.set_global_transform(tr)
	queue_free()
