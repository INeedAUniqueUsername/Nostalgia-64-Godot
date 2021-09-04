extends Node

export(PackedScene) var projectile
export(float) var fireCooldown
export(NodePath) var position

var fireCooldownLeft = 0;
var velocity;

var fireLeft
var fireRight

func _ready():
	
	fireLeft = get_parent().get_node("FireLeft")
	fireRight = get_parent().get_node("FireRight")
	
	if(!projectile):
		warn("projectile missing")
	if(!position):
		warn("pos missin;")
	position = get_node(position)
	velocity = position.get_node("Velocity")
	if(!velocity):
		warn("vel missing")
	if(fireCooldown < 1):
		warn("fireCooldown < 1")
	pass
func _process(delta):
	if(fireCooldownLeft > 0):
		fireCooldownLeft -= delta
	elif(fireLeft.active && fireRight.active):
		info("firing")
		fireCooldownLeft = fireCooldown
		var shot = projectile.instance();
		var p = position.get_global_transform()
		var v = velocity.get_global_transform()
		shot.set_transform(p.orthonormalized())
		shot.linear_velocity = get_parent().linear_velocity;
		shot.apply_impulse(Vector3(0, 0, 0), v.origin - p.origin)
		
		var creator = get_parent().get_parent();
		
		p = shot.get_node("Projectile");
		if(p != null):
			p.creator = creator;
		p = shot.get_node("Pull")
		if(p != null):
			p.creator = creator;
		
		add_child(shot)
	pass
	
export(bool) var printErrors = false;
export(bool) var printWarnings = true;
export(bool) var printInfo = true;
func warn(message):
	if(printErrors):
		printerr("" + get_path() + ">" + message)
	elif(printWarnings): print("" + get_path() + ">" + message)
	pass
func info(message):
	if(printInfo): print("" + get_path() + ">" + message)
	pass
