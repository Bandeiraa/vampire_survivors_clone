extends Node2D
class_name EnemySpawner

onready var timer: Timer = get_node("SpawnTimer")
onready var wave_timer: Timer = get_node("WaveTimer")

var current_wave: String = "wave_1"

var spawn_point_list: Array = [
	Vector2(0, 192),
	Vector2(384, 192),
	Vector2(-384, 192),
	Vector2(384, 0),
	Vector2(384, 192),
	Vector2(384, -192)
]

var spawn_dictionary: Dictionary = {
	"wave_1": {
		"enemies_list": [
			preload("res://scenes/enemy/ghost.tscn"),
			preload("res://scenes/enemy/bat.tscn"),
			preload("res://scenes/enemy/big_ghost.tscn")
		],
		
		"spawn_probability_list": [
			[1, 65],
			[65, 95],
			[95, 100]
		],
		
		"spawn_cooldown": [
			0.8,
			2.4
		],
		
		"next_wave_time": 180,
		"next_wave": "wave_2"
	}
}

func _ready() -> void:
	randomize()
	wave_timer.start(120)
	
	
func spawn() -> void:
	var spawn_position_index: int = randi() % spawn_point_list.size()
	var character_position: Vector2 = global_info.character.global_position
	var spawn_position: Vector2 = spawn_point_list[spawn_position_index] + character_position
	
	var random_number: int = randi() % 100 + 1
	var spawn_list: Array = spawn_dictionary[current_wave]["spawn_probability_list"]
	
	var aux_index: int = 0
	for list in spawn_list:
		if random_number >= list.min() and random_number < list.max():
			var enemy: EnemyTemplate = spawn_dictionary[current_wave]["enemies_list"][aux_index].instance()
			enemy.global_position = spawn_position
			add_child(enemy)
			return
			
		aux_index += 1
		
		
func on_spawn_timer_timeout() -> void:
	var spawn_cooldown_list: Array = spawn_dictionary[current_wave]["spawn_cooldown"]
	var spawn_cooldown: float = rand_range(spawn_cooldown_list.min(), spawn_cooldown_list.max())
	timer.start(spawn_cooldown)
	spawn()
	
	
func on_wave_timer_timeout() -> void:
	wave_timer.start(spawn_dictionary[current_wave]["next_wave_time"])
	current_wave = spawn_dictionary[current_wave]["next_wave"]
