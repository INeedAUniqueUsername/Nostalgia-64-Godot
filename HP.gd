extends Node

export(int) var hp

func damage(deltaHp):
	hp -= deltaHp;
	if(hp < 1):
		get_parent().queue_free()


