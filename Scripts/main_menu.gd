extends Node2D

func _ready() -> void:
	Pause_menu.can_pause = false

func _on_start_pressed() -> void:
	Pause_menu.can_pause = true
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_options_pressed() -> void:
	pass # pode no futuro colocar um menu de opçoes por enquanto isso é apenas um placeHolder hehe


func _on_quit_pressed() -> void:
	get_tree().quit()
