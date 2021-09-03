extends Camera

export(NodePath) var playerLeft;
export(NodePath) var playerRight;

func _ready():
	if(playerLeft is NodePath):
		playerLeft = get_node(playerLeft)
	if(playerRight is NodePath):
		playerRight = get_node(playerRight)

func _process(delta):
	if(is_instance_valid(playerLeft) && is_instance_valid(playerRight)):
		var pl = playerLeft.transform.origin;
		var pr = playerRight.transform.origin;
		var mid = pl.linear_interpolate(pr, 0.5);
		var distance = pl.distance_to(pr);
		distance = max(abs(pl.x - pr.x), abs(pl.y - pr.y))
		self.transform.origin = Vector3(mid.x, mid.y, distance + 2)
	elif(is_instance_valid(playerLeft)):
		follow(playerLeft)
	elif(is_instance_valid(playerRight)):
		follow(playerRight)
				
func follow(pov):
	var p = pov.transform.origin;
	var origin = self.transform.origin;
	
	var x = origin.x + (p.x - origin.x) / 30
	var y = origin.y + (p.y - origin.y) / 30
	var z = origin.z
	
	if(origin.z < 10):
		z = z + 1/30
	if(origin.z > 10):
		z = z - 1/30
	self.transform.origin = Vector3(x, y, z)
		
	pass
