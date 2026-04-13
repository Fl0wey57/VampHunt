extends CharacterBody2D
class_name Vamp

## The HP amount this vampire has against shots
@export var hp:int = 10
## Default move speed
@export var move_speed:float = 20.0 * 1000
## Default wave length
@export var wave_length:float = 250.0
## Default wave duration divider
@export var wave_duration:float = 5

# Child nodes
@onready var sprite_2d = $Sprite2D as Sprite2D

## The variable for storing how long the node has been created[br]
##
## Generally used for physics calculations
var elapsed_time:float = 0.0

## Default direction the vampire will fly in
var direction:Vector2 = Vector2.LEFT

func _ready() -> void:
	elapsed_time = 0.0

func _physics_process(delta: float) -> void:
	elapsed_time += delta
	
	# The base vampire moves with the combined direction of a straight motion and a wave motion
	var velocity_line:Vector2 = direction * move_speed * delta
	var velocity_wave:Vector2 = Vector2(0, sin(elapsed_time * wave_duration) * wave_length)
	
	velocity = velocity_line + velocity_wave
	
	move_and_slide()

## Removes the vampire from the game
func Die() -> void:
	call_deferred("queue_free")

## Registers damage to the vampire HP and check for [method Die][br]
##
## See [member hp]
func Take_Damage(amount:int) -> void:
	hp -= amount
	if hp <= 0:
		Die()
