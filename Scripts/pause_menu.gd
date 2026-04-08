extends CanvasLayer

## Check for situations where the pause menu does NOT apply
var can_pause:bool = true

func _ready() -> void:
	visible = false
	get_tree().paused = false

# Toggle for the pause using Input
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and can_pause:
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true

func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_quit_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
