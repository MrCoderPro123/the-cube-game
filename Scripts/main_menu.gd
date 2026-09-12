extends Control

const LEVEL_1 = preload("uid://8ggbt2seeq2v")
const SHOP_MENU = preload("uid://hk6vb8po2bsk")

func _on_play_btn_pressed() -> void:
	#GlobalValues.set_coins(0)
	# Level is Indexed from 0
	GlobalValues.set_level(0)
	get_tree().change_scene_to_packed(LEVEL_1)

func _on_shop_btn_pressed() -> void:
	get_tree().change_scene_to_packed(SHOP_MENU)

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
