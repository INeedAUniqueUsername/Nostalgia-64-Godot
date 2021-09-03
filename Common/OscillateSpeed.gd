extends Node
export(float) var turnRateDegrees
export(float) var time
export(float) var halfPeriod
export(float) var angledSpeed

var turnRate

func _ready():
	turnRate = deg2rad(turnRateDegrees)
	pass

func speed(delta):
	var rb = get_parent()
	var velocity = rb.linear_velocity;
	#fix this
	var velocityAngle = atan2(velocity.y, velocity.x)
	#print(velocityAngle)
	var vec = Vector3(cos(velocityAngle) * angledSpeed, sin(velocityAngle) * angledSpeed, 0)
	rb.apply_impulse(Vector3(0, 0, 0),
		- angledSpeed * sin(time / halfPeriod) * vec
		+ angledSpeed * sin((time + delta)/halfPeriod) * vec)
	pass

func _process(delta):
	
	speed(delta)
		
	time += delta
	if(time >= halfPeriod * 2):
		time = 0
	pass
