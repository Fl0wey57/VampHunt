extends Node2D

# Deprecated
#@export_group("Movement", "aim_")
#@export var aim_hspeed:float = 500.0
#@export var aim_vspeed:float = 400.0
#@export_group("")

## timer for shoot cooldown oh yeah  
@export var timer_cooldown:float = 1.0

## The int registering which vampires this gun can kill
@export var bullet_flag:int = 0

# Child nodes
@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var area_collision_shape_2d = $Area2D/AreaCollisionShape2D as CollisionShape2D
@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var timer_shoot_cooldown = $TimerShootCooldown as Timer

# viewport
var viewport:Vector2

## Initial transparency for when not shooting
var initial_transparency:int

func _ready() -> void:
	initial_transparency = sprite_2d.self_modulate.a
	timer_shoot_cooldown.wait_time = timer_cooldown
	viewport = get_viewport().get_visible_rect().size

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ouch"):
		get_parent().player_damage.emit(1)
	
	if Input.is_action_just_pressed("shoot") and timer_shoot_cooldown.is_stopped():
		Shoot()
	
	MoveCursor(get_global_mouse_position())

## The main function for moving the aim.[br]
## [param pos] is the [Vector2] to move toward, limited by the viewport
func MoveCursor(pos:Vector2) -> void:
	var pos_x = pos.x
	var pos_y = pos.y
	
	position.x = clamp(pos_x, 0, viewport.x)
	position.y = clamp(pos_y, 0, viewport.y)


## The main function for shooting.[br]
## [b][u]Cancels all previous animations, including itself.[/u][/b]
func Shoot() -> void:
	print("pew")
	animation_player.stop()
	animation_player.play("shoot")
	timer_shoot_cooldown.start()
