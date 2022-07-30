extends Node

export(float) var radius
export(int) var segmentCount
export(float) var segmentSpan
export(float) var segmentCreateTime
var segmentCreateTimeLeft
export(float) var segmentRegenRate
export(PackedScene) var segmentScene
var segments

func _ready():
	segmentCreateTimeLeft = segmentCreateTime
	segments = []
	for i in range(segmentCount):
		segments.push_back(null)
func _process(delta):
	var pos = get_parent().global_transform.origin
	var facing = get_parent().rotation_degrees.z+180
	var centerIndex = floor(segmentCount/2)
	
	for i in range(segmentCount):
		var s = segments[i]
		if s != null:
			if(is_instance_valid(s) && s.is_inside_tree()):
				var segmentAngle = (i - centerIndex) * segmentSpan
				s.transform.origin = pos + Vector3(cos(deg2rad(facing + segmentAngle)) * radius, sin(deg2rad(facing + segmentAngle)) * radius, 0)
				s.set_rotation_degrees(Vector3(0, 0, facing + segmentAngle))
				s = s.get_node("HP")
				s.hp = min(s.hp + segmentRegenRate, s.maxHp)
			else:
				segments[i] = null
	if(segmentCreateTimeLeft > 0):
		segmentCreateTimeLeft -= delta
	else:
		segmentCreateTimeLeft = segmentCreateTime
		for i in range(segmentCount):
			if segments[i] == null:
				var segmentCreated = segmentScene.instance()
				var segmentAngle = (i - centerIndex) * segmentSpan
				segmentCreated.transform.origin = pos + Vector3(cos(deg2rad(facing + segmentAngle)) * radius, sin(deg2rad(facing + segmentAngle)) * radius, 0)
				segmentCreated.set_rotation_degrees(Vector3(0, 0, facing + segmentAngle))
				segmentCreated.get_node("Sprite").opacity = 0
				#get_parent().get_node("Segments").
				add_child(segmentCreated)
				segments[i] = segmentCreated
