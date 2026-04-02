extends Node2D

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_options_pressed() -> void:
	pass # pode no futuro colocar um menu de opçoes por enquanto isso é apenas um placeHolder hehe


func _on_quit_pressed() -> void:
	get_tree().quit()
