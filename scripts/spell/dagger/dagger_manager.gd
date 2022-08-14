extends Node2D
class_name DaggerManager

const DAGGER: PackedScene = preload("res://scenes/spell/dagger/dagger.tscn")

onready var timer: Timer = get_node("Timer")

var spell_level: int = -1
var dagger_level_dict: Dictionary = {
	1: {
		"spawn_amount": 1,
		"damage": [
			5,
			10
		],
		"move_speed": 90,
		"spawn_cooldown": 2.5
	}
}

func _ready() -> void:
	randomize()
	spell_level = 1
	timer.start(dagger_level_dict[spell_level]["spawn_cooldown"])
	
	
func spawn() -> void:
	var spell: Dagger = DAGGER.instance()
	var damage_list: Array = dagger_level_dict[spell_level]["damage"]
	
	spell.speed = dagger_level_dict[spell_level]["move_speed"]
	spell.damage = int(rand_range(damage_list.min(), damage_list.max()))
	spell.global_position = global_position
	
	get_tree().root.call_deferred("add_child", spell)
	
	
func on_timer_timeout() -> void:
	for i in dagger_level_dict[spell_level]["spawn_amount"]:
		spawn()
		
	timer.start(dagger_level_dict[spell_level]["spawn_cooldown"])
