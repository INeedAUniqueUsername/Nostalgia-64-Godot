extends Node
export(float) var turnRateDegrees
export(float) var time
export(float) var halfPeriod
export(float) var angledSpeed
export(bool) var right

var turnRate

func _ready():
	turnRate = deg2rad(turnRateDegrees)
	pass

func turn(inc):
	var rb = get_parent()
	var velocity = rb.linear_velocity;
	#fix this
	var velocityAngle = atan2(velocity.y, velocity.x)	#Conflicts with official documentation
	#print(velocityAngle)
	rb.apply_impulse(Vector3(0, 0, 0),
		-Vector3(angledSpeed * cos(velocityAngle), angledSpeed * sin(velocityAngle), 0)
		+ Vector3(angledSpeed * cos(velocityAngle + inc), angledSpeed * sin(velocityAngle + inc), 0))
	pass

func _process(delta):
	if(right):
		turn(-turnRate * delta)
	else:
		turn(turnRate * delta)
	
	time += delta
	if(time >= halfPeriod):
		time = 0
		right = !right
	pass
