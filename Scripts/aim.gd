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
## The amount of damage this gun type inflicts
@export var damage_amount:int = 10

# Child nodes
@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var area_2d = $Area2D as Area2D

# viewport
var viewport:Vector2

## Initial color for when not shooting
var initial_transparency:Color
## Color to be applied once a shoot is pressed
var shoot_transparency:Color
## Check to not shoot while recharging
var is_on_cooldown:bool = false

func _ready() -> void:
	initial_transparency = sprite_2d.self_modulate
	shoot_transparency = Color("ffffff37")
	viewport = get_viewport().get_visible_rect().size

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ouch"):
		get_parent().player_damage.emit(1)
	
	#CHECK HERE
	if Input.is_action_just_pressed("shoot") and !is_on_cooldown:
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
	# Checks for collision with all vamps in aim
	var bodies := area_2d.get_overlapping_bodies()
	for i in bodies:
		if i is Vamp:
			(i as Vamp).Take_Damage(damage_amount)
	
	# Handles the code animation for cooldown using Tween
	is_on_cooldown = true
	sprite_2d.self_modulate = shoot_transparency
	var shoot_tween = get_tree().create_tween()
	shoot_tween.tween_property(sprite_2d,"self_modulate",initial_transparency,timer_cooldown).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	shoot_tween.tween_callback(func(): is_on_cooldown = false)
