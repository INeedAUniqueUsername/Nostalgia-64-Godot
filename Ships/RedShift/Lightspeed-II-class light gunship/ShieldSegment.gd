extends Node

var hp = 0
export(float) var maxHp

func _process(delta):
	get_parent().get_node("Sprite").opacity = hp / maxHp
	pass

func damage(deltaHp):
	hp -= deltaHp
	if(hp < 1):
		get_parent().queue_free()
