extends Node2D
class_name EnemySpawner

onready var timer: Timer = get_node("SpawnTimer")

var current_wave: String = "wave_1"

var spawn_point_list: Array = [
	Vector2(0, 192),
	Vector2(384, 192),
	Vector2(-384, 192),
	Vector2(384, 0),
	Vector2(384, 192),
	Vector2(384, -192)
]

var wave_list: Array = [
	"wave_1",
	"wave_2",
	"wave_3"
]

var spawn_dictionary: Dictionary = {
	"wave_1": {
		"enemies_list": [
			preload("res://scenes/enemy/ghost.tscn")
		],
		
		"spawn_cooldown": [
			1.5,
			3.0
		]
	}
}

func _ready() -> void:
	randomize()
	
	
func spawn() -> void:
	var spawn_position_index: int = randi() % spawn_point_list.size()
	var character_position: Vector2 = global_info.character.global_position
	var spawn_position: Vector2 = spawn_point_list[spawn_position_index] + character_position
	
	var enemy_index: int = randi() % spawn_dictionary[current_wave]["enemies_list"].size()
	var enemy: EnemyTemplate = spawn_dictionary[current_wave]["enemies_list"][enemy_index].instance()
	enemy.global_position = spawn_position
	add_child(enemy)
	
	
func on_spawn_timer_timeout() -> void:
	var spawn_cooldown_list: Array = spawn_dictionary[current_wave]["spawn_cooldown"]
	var spawn_cooldown: float = rand_range(spawn_cooldown_list.min(), spawn_cooldown_list.max())
	timer.start(spawn_cooldown)
	spawn()
