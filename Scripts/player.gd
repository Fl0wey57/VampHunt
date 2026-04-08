extends Node2D

@export_group("statistics", "stats_")
## Max HP of the player
@export var stats_max_hp:int = 10
## Starting amount of coins (for debug)
@export var stats_start_coins:int = 0

## Toggle the third gun
@export var extra_gun_unlock:bool = false
## The index [int] for starting gun [code]n-1[/code] for value [code]n[/code][br]
##
## Example: index [code]1[/code] selects gun [code]2[/code]
@export var start_gun_index:int = 0

## [Signal] for any player damaged scenario
signal player_damage(amount:int)

## Current HP of the Player
var hp:int
## Current gun index of the Player [br]
## See [member start_gun_index]
var current_gun_index:int

# Reference nodes
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

## Selects the gun with [param select_gun_index] from the available loadout.[br]
##
## On fallback, gun 1 (index [code]0[/code]) is selected.
func ChangeGun(select_gun_index:int) -> void:
	# Removes all "aim..." nodes from this Player
	for i in get_children():
		if i.name.begins_with("aim"):
			remove_child(i)
	
	# Adds the corresponding gun from index
	current_gun_index = select_gun_index
	match select_gun_index:
		1:
			gun2.position = get_global_mouse_position()
			add_child(gun2)

		_:
			gun1.position = get_global_mouse_position()
			add_child(gun1)

## Reduces HP by [param amount] and checks for [method GameOver][br]
##
## See [member hp]
func TakeDamage(amount:int) -> void:
	hp -= amount
	#print(hp)
	
	if hp <= 0:
		hp = 0
		GameOver()

## [color=yellow](WIP)[/color] End gameplay loop
func GameOver() -> void:
	print("mêrreu")
