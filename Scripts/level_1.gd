extends Node

@onready var aim:Node2D = $Aim
var aim_start_x:float
var aim_start_y:float

func _ready() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	aim_start_x = viewport_size.x /2
	aim_start_y = viewport_size.y /2
	
	StartGame()

func StartGame() -> void:
	aim.position.x = aim_start_x
	aim.position.y = aim_start_y
