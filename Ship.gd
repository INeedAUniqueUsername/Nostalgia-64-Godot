extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var segments = get_children()
	var c = len(segments)
	for i in range(c):
		var s = segments[i]
		for j in range(c - (i + 1)):
			#continue
			s.add_collision_exception_with(segments[j + i])
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
