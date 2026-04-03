extends Node2D

@export_group("Movement", "aim_")
@export var aim_hspeed:float = 500.0
@export var aim_vspeed:float = 400.0
@export_group("")

## timer for shoot cooldown oh yeah  
@export var timer_cooldown:float = 1.0

@export var bullet_flag:int = 0

@onready var sprite_2d = $Sprite2D
@onready var area_collision_shape_2d = $Area2D/AreaCollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var timer_shoot_cooldown: Timer = $TimerShootCooldown

# Input Checkers
#var horizontal_axis:int
#var vertical_axis:int
# viewport
var viewport:Vector2

var initial_transparency:int

func _ready() -> void:
	initial_transparency = sprite_2d.self_modulate.a
	timer_shoot_cooldown.wait_time = timer_cooldown
	viewport = get_viewport().get_visible_rect().size

func _process(delta: float) -> void:
	# Normalize inputs
	#horizontal_axis = int(Input.get_axis("left","right"))
	#vertical_axis = int(Input.get_axis("up","down"))
	#print("H:"+str(horizontal_axis)+" , V:"+str(vertical_axis))
	
	if Input.is_action_just_pressed("ouch"):
		get_parent().player_damage.emit(1)
	
	if Input.is_action_just_pressed("shoot") and timer_shoot_cooldown.is_stopped():
		Shoot()
	
	MoveCursor(get_global_mouse_position(), delta)

## The main function for moving the aim.[br]
## [param h] and [param v] are the horizontal and vertical distances to move,
## while [param d] is delta
func MoveCursor(pos:Vector2, d: float) -> void:
	var posx = pos.x
	var posy = pos.y
	
	position.x = clamp(posx, 0, viewport.x)
	position.y = clamp(posy, 0, viewport.y)


## The main function for shooting.[br]
## [b][u]Cancels all previous animations, including itself.[/u][/b]
func Shoot() -> void:
	print("pew")
	animation_player.stop()
	animation_player.play("shoot")
	timer_shoot_cooldown.start()
