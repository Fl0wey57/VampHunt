extends CharacterBody2D
class_name Vamp

## The HP amount this vampire has against shots
@export var hp:int = 30
## Default move speed
@export var move_speed:float = 20.0 * 1000

# Child nodes
@onready var sprite_2d: Sprite2D = $Sprite2D

## Default direction the vampire will fly in
var direction:Vector2 = Vector2.LEFT

func _physics_process(delta: float) -> void:
	velocity = direction * move_speed * delta
	
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
