extends Node2D
class_name SpellManager

onready var timer: Timer = get_node("Timer")

var spell_level: int = -1
var spell_level_dict: Dictionary = {}

export(PackedScene) var spell_to_instance

func _ready() -> void:
	randomize()
	spell_level = 1
	
	
func spawn() -> void:
	pass
	
	
func on_timer_timeout() -> void:
	for i in spell_level_dict[spell_level]["spawn_amount"]:
		spawn()
		
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
