extends Camera

export(NodePath) var playerLeft;
export(NodePath) var playerRight;

func _ready():
	playerLeft = get_node(playerLeft)
	playerRight = get_node(playerRight)

func _process(delta):
	if(is_instance_valid(playerLeft) && is_instance_valid(playerRight)):
		var pl = playerLeft.transform.origin;
		var pr = playerRight.transform.origin;
		var mid = pl.linear_interpolate(pr, 0.5);
		var distance = pl.distance_to(pr);
		distance = max(abs(pl.x - pr.x), abs(pl.y - pr.y))
		self.transform.origin = Vector3(mid.x, mid.y, distance + 2)
