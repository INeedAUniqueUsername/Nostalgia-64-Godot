extends Button

export(PackedScene) var nextScene

func onPressed():
	get_tree().change_scene_to(nextScene)
