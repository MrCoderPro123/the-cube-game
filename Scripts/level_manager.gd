extends Node

const levels: Array[PackedScene] = [
	preload("res://Levels/level_1.tscn"),
	preload("uid://ckdjjd6lrhiqu"),
	preload("uid://cxr3hm2m16kd"),
	preload("uid://dgaysa3wwu000"), 
	preload("uid://clm00ofjbfg1r"), 
	preload("uid://bmeqglrwdcbcr")
]

const MAIN_MENU = preload("uid://bvgvw3ct0bv1o")

func restart_current_scene():
	get_tree().call_deferred("reload_current_scene")

func start_from_level_one():
	get_tree().call_deferred("change_scene_to_packed", levels[0])
	GlobalValues.set_level(0)

func switch_to_main_menu():
	get_tree().call_deferred("change_scene_to_packed", MAIN_MENU)

func next_level():
	var current_idx = GlobalValues.get_level()
	var next_idx = current_idx + 1
	
	if next_idx < levels.size():
		GlobalValues.set_level(next_idx)
		get_tree().call_deferred("change_scene_to_packed", levels[next_idx])
	else:
		print("Finished all Levels")
		get_tree().change_scene_to_packed(MAIN_MENU)
