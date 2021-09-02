extends Button



func onPressed():
	if(self.name == "DuelMode"):
		duel()

func duel():
	
	get_tree().change_scene("res://Duel.tscn")
