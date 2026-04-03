extends Node

var player:Node
var aim:Node2D
var aim_start_x:float
var aim_start_y:float

func _ready() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	aim_start_x = viewport_size.x /2
	aim_start_y = viewport_size.y /2
	
	player = find_child("player")
	aim = player.find_child("aim", false)
	
	StartGame()

func StartGame() -> void:
	pass
