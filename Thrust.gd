extends Node

export(NodePath) var pos
export(NodePath) var accel			#Local acceleration; We use the difference between this and pos to get the impulse
export(float) var thrustMultiplier = 1
export(float) var exhaustInterval
export(PackedScene) var exhaust

var thrustTime = 0
var exhaustTime = 0

var active = false;

func onPressed():
	active = true
	pass
func onReleased():
	active = false
	pass

var prevPos:  Vector3
func _ready():
	pos = get_node(pos)
	accel = get_node(accel)
	prevPos = pos.get_global_transform().origin
func _process(delta):
	var currentPos = pos.get_global_transform().origin
	var vel = (currentPos - prevPos) / delta
	prevPos = currentPos
	
	if(active):
		var impulse = (accel.get_global_transform().origin - pos.get_global_transform().origin);
		if(exhaust):
			if(exhaustTime > 0):
				exhaustTime -= delta
			else:
				exhaustTime = exhaustInterval
				var exhaustShot = exhaust.instance()
				exhaustShot.set_transform(pos.get_global_transform())
				exhaustShot.linear_velocity = vel - impulse
				#exhaustShot.apply_impulse(Vector3(0, 0, 0), -impulse)
				
				var p = exhaustShot.get_node("Projectile")
				if(p != null):
					p.creator = get_parent().get_parent()
				get_tree().get_nodes_in_group("World")[0].add_child(exhaustShot)
		
		get_parent().apply_impulse(pos.translation, impulse * delta * thrustMultiplier)
		
	pass
