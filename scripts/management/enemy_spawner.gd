extends Node2D
class_name EnemySpawner

onready var timer: Timer = get_node("SpawnTimer")
onready var wave_timer: Timer = get_node("WaveTimer")

var axis_list: Array = [
	"horizontal",
	"vertical"
]

var current_wave: String = "wave_1"

var spawn_dictionary: Dictionary = {
	"wave_1": {
		"enemies_list": [
			preload("res://scenes/enemy/rat.tscn"),
			preload("res://scenes/enemy/ghost.tscn"),
			preload("res://scenes/enemy/bat.tscn")
		],
		
		"spawn_probability_list": [
			[1, 45],
			[45, 80],
			[80, 100]
		],
		
		"spawn_cooldown": [
			0.4,
			1.2
		],
		
		"next_wave_time": 180,
		"next_wave": "wave_2"
	},
	
	"wave_2": {
		"enemies_list": [
			preload("res://scenes/enemy/ghost.tscn"),
			preload("res://scenes/enemy/bat.tscn"),
			preload("res://scenes/enemy/crabby.tscn"),
			preload("res://scenes/enemy/big_ghost.tscn")
		],
		
		"spawn_probability_list": [
			[1, 25],
			[25, 60],
			[60, 95],
			[99, 100]
		],
		
		"spawn_cooldown": [
			0.35,
			1.1
		],
		
		"next_wave_time": 240,
		"next_wave": "wave_3"
	},
	
	"wave_3": {
		"enemies_list": [
			preload("res://scenes/enemy/bat.tscn"),
			preload("res://scenes/enemy/crabby.tscn"),
			preload("res://scenes/enemy/spider.tscn"),
			preload("res://scenes/enemy/big_ghost.tscn")
		],
		
		"spawn_probability_list": [
			[1, 25],
			[25, 60],
			[60, 99],
			[99, 100]
		],
		
		"spawn_cooldown": [
			0.3,
			1.0
		],
		
		"next_wave_time": 300,
		"next_wave": "wave_4"
	},
	
	"wave_4": {
		"enemies_list": [
			preload("res://scenes/enemy/spider.tscn"),
			preload("res://scenes/enemy/cyclop.tscn"),
			preload("res://scenes/enemy/big_ghost.tscn")
		],
		
		"spawn_probability_list": [
			[1, 90],
			[95, 99],
			[99, 100]
		],
		
		"spawn_cooldown": [
			0.25,
			0.9
		],
		
		"next_wave_time": 360,
		"next_wave": "wave_5"
	},
	
	"wave_5": {
		"enemies_list": [
			preload("res://scenes/enemy/spider.tscn"),
			preload("res://scenes/enemy/big_ghost.tscn"),
			preload("res://scenes/enemy/cyclop.tscn"),
			preload("res://scenes/enemy/dark_mage.tscn")
		],
		
		"spawn_probability_list": [
			[1, 65],
			[65, 90],
			[90, 99],
			[99, 100]
		],
		
		"spawn_cooldown": [
			0.2,
			0.8
		],
		
		"next_wave_time": 0,
		"next_wave": ""
	}
}

func _ready() -> void:
	randomize()
	wave_timer.start(120)
	
	
func spawn() -> void:
	var point_list: Array = []
	var character_spawn_point: Node2D = global_info.character.get_node("SpawnPointList")
	
	for point in character_spawn_point.get_children():
		point_list.append(point.global_position)
		
	var min_point: Vector2 = point_list.min()
	var max_point: Vector2 = point_list.max()
	
	var x_lock: Array = [min_point.x, max_point.x]
	var y_lock: Array = [min_point.y, max_point.y]
	
	var spawn_position: Vector2 = Vector2.ZERO
	
	var axis: String = axis_list[randi() % axis_list.size()]
	match axis:
		"horizontal":
			spawn_position.x = rand_range(min_point.x, max_point.x)
			spawn_position.y = y_lock[randi() % y_lock.size()]
			
		"vertical":
			spawn_position.x = x_lock[randi() % x_lock.size()]
			spawn_position.y = rand_range(min_point.y, max_point.y)
			
	var random_number: int = randi() % 100 + 1
	var spawn_list: Array = spawn_dictionary[current_wave]["spawn_probability_list"]
	
	var aux_index: int = 0
	for list in spawn_list:
		if random_number > list.min() and random_number <= list.max():
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
	if spawn_dictionary[current_wave]["next_wave"] == "":
		return
		
	wave_timer.start(spawn_dictionary[current_wave]["next_wave_time"])
	current_wave = spawn_dictionary[current_wave]["next_wave"]
