extends CanvasLayer
class_name Interface

const LEVEL_UP_SCENE: PackedScene = preload("res://scenes/interface/level_up_container.tscn")

onready var joystick: Area2D = get_node("Joystick")
onready var level: Label = get_node("ExpContainer/VContainer/Level")
onready var experience: Label = get_node("ExpContainer/VContainer/CurrentExp")

func update_exp(current_level: int, current_exp: int, target_exp: int) -> void:
	level.text = "Level: " + str(current_level)
	experience.text = "Exp: " + str(current_exp) + "/" + str(target_exp)
	
	
func spawn_level_up_container() -> void:
	joystick.disabled = true
	get_tree().paused = true
	var level_up_scene = LEVEL_UP_SCENE.instance()
	level_up_scene.connect("close_slot_container", self, "on_container_closed")
	add_child(level_up_scene)
	
	
func on_container_closed() -> void:
	joystick.disabled = false
