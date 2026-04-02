extends Node2D

@export_group("Movement", "aim_")
@export var aim_hspeed:float = 500.0
@export var aim_vspeed:float = 400.0
@export_group("")

@onready var sprite_2d = $Sprite2D
@onready var area_collision_shape_2d = $Area2D/AreaCollisionShape2D
@onready var animation_player = $AnimationPlayer

# Input Checkers
var horizontal_axis : int
var vertical_axis : int

var initial_transparency:int

func _ready() -> void:
	initial_transparency = sprite_2d.self_modulate.a

func _process(delta: float) -> void:
	# Normalize inputs
	horizontal_axis = int(Input.get_axis("left","right"))
	vertical_axis = int(Input.get_axis("up","down"))
	#print("H:"+str(horizontal_axis)+" , V:"+str(vertical_axis))
	
	if Input.is_action_just_pressed("shoot"):
		Shoot()
	
	MoveCursor(horizontal_axis, vertical_axis, delta)

## The main function for moving the aim.[br]
## [param h] and [param v] are the horizontal and vertical distances to move,
## while [param d] is delta
func MoveCursor(h:int, v:int, d: float) -> void:
	position.x += h * aim_hspeed * d
	position.y += v * aim_vspeed * d

## The main function for shooting.[br]
## [b][u]Cancels all previous animations, including itself.[/u][/b]
func Shoot() -> void:
	print("pew")
	animation_player.stop()
	animation_player.play("shoot")
