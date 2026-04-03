extends Node2D

@export_group("statistics", "stats_")
@export var stats_max_hp:int = 10
@export var stats_start_coins:int = 0

@export var extra_gun_unlock:bool = false
@export var start_gun_index:int = 0

signal player_damage(amount:int)

var hp:int
var current_gun_index:int
@onready var gun1:Node2D = $aim
@onready var gun2:Node2D = $aim2

func _ready() -> void:
	hp = stats_max_hp
	current_gun_index = start_gun_index
	player_damage.connect(TakeDamage)
	
	remove_child(gun2)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("gun1") and current_gun_index != 0:
		ChangeGun(0)
	elif Input.is_action_just_pressed("gun2") and current_gun_index != 1:
		ChangeGun(1)

func ChangeGun(select_gun_index:int) -> void:
	current_gun_index = select_gun_index
	match select_gun_index:
		1:
			gun2.position = get_global_mouse_position()
			add_child(gun2)
			remove_child(gun1)

		_:
			gun1.position = get_global_mouse_position()
			add_child(gun1)
			remove_child(gun2)

func TakeDamage(amount:int) -> void:
	hp -= amount
	print(hp)
	
	if hp <= 0:
		hp = 0
		GameOver()

func GameOver() -> void:
	print("mêrreu")
