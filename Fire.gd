extends Node

export(PackedScene) var projectile
export(float) var fireCooldown
export(NodePath) var position

export(bool) var detonateOnPress = false
var lastShot


var fireCooldownLeft = 0;
var active = false
var velocity;
func onPressed():
	active = true
	
	if(detonateOnPress && lastShot != null && is_instance_valid(lastShot) && lastShot.is_inside_tree()):
		lastShot.get_node("Lifetime").lifetime = 0.0
	pass
func onReleased():
	active = false;
	pass
	
func _ready():
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
	elif(active):
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
			lastShot = shot
		p = shot.get_node("Pull")
		if(p != null):
			p.creator = creator;
			lastShot = shot
		
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
