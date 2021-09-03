extends Node

var creator;

var targets = []
var timers = []
func _ready():
	var p = get_parent()
	p.get_node("SeekRange").connect("body_entered", self, "on_body_entered")
	creator = p.get_node("Projectile").creator

func on_body_entered(other):
	var o = other;
	while(o != null):
		if(o == creator):
			return;
		o = o.get_parent()
		
	var hit = null;
	
	for name in ["ThrustLeft", "ThrustMiddle", "ThrustRight", "FireLeft", "FireMiddle", "FireRight"]:
		if(other.has_node(name)):
			hit = other.get_node(name)
			break
		
	if(hit != null && randf() < 0.5):
		hit.onPressed();
		
func on_body_exited(other):
	var o = other;
	while(o != null):
		if(o == creator):
			return;
		o = o.get_parent()
		
	var hit = null;
	
	for name in ["ThrustLeft", "ThrustMiddle", "ThrustRight", "FireLeft", "FireMiddle", "FireRight"]:
		if(other.has_node(name)):
			hit = other.get_node(name)
			break
		
	if(hit != null):
		hit.onReleased();
		
func _process(delta):
#	if(target):
#		var t = target.transform.origin
#		var s = self.transform.origin;
#		var offset = t - s
#		var rb = get_parent()
#		var speed = rb.linear_velocity.length()
#		var timeToHit = offset.length / speed
#		var nextOffset = t + (target.linear_velocity - rb.linear_velocity) * timeToHit + s
#		var angle = atan2(nextOffset.y, nextOffset.x)
#		rb.linear_velocity = Vector3(cos(angle) * speed, sin(angle) * speed, 0)
		
		
	pass
