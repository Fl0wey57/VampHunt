extends CharacterBody2D
class_name Vamp

@export var hp:int = 30
@export var move_speed:float = 20.0 * 1000

@onready var sprite_2d: Sprite2D = $Sprite2D

var direction:Vector2 = Vector2.LEFT

func _physics_process(delta: float) -> void:
	velocity = direction * move_speed * delta
	
	move_and_slide()

func die() -> void:
	call_deferred("queue_free")

func take_damage(amount:int) -> void:
	hp -= amount
	if hp <= 0:
		die()
