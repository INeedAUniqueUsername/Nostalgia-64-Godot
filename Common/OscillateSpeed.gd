extends Node
export(float) var turnRateDegrees
export(float) var time
export(float) var halfPeriod
export(float) var angledSpeed

var turnRate

func _ready():
	turnRate = deg2rad(turnRateDegrees)
	pass

func speed(inc):
	var rb = get_parent()
	var velocity = rb.linear_velocity;
	#fix this
	var velocityAngle = atan2(velocity.y, velocity.x)	#Conflicts with official documentation
	#print(velocityAngle)
	var vec = Vector3(cos(velocityAngle) * angledSpeed, sin(velocityAngle) * angledSpeed, 0)
	rb.apply_impulse(Vector3(0, 0, 0),
		- angledSpeed * cos(velocityAngle) * vec
		+ angledSpeed * cos(velocityAngle + inc) * vec)
	pass

func _process(delta):
	
	speed(-turnRate * delta)
		
	time += delta
	if(time >= halfPeriod):
		time = 0
	pass
