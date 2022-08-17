extends CanvasLayer
class_name Interface

signal joystick_disabled

const JOYSTICK: PackedScene = preload("res://scenes/management/joystick.tscn")
const LEVEL_UP_SCENE: PackedScene = preload("res://scenes/interface/level_up_container.tscn")

onready var experience: Control = get_node("ExpContainer")

var has_joystick: bool = false

func init_exp_bar(current_level: int, current_exp: int, target_exp: int) -> void:
	experience.init_bar(current_level, current_exp, target_exp)
	
	
func update_exp(current_level: int, current_exp: int, target_exp: int) -> void:
	experience.update_exp(current_level, current_exp, target_exp)
	
	
func spawn_level_up_container() -> void:
	get_tree().paused = true
	emit_signal("joystick_disabled")
	var level_up_scene = LEVEL_UP_SCENE.instance()
	level_up_scene.connect("close_slot_container", self, "on_slot_container_closed")
	add_child(level_up_scene)
	
	
func _input(event) -> void:
	if not event is InputEventScreenTouch or has_joystick:
		return
		
	spawn_joystick(event.position)
	
	
func spawn_joystick(spawn_position: Vector2) -> void:
	has_joystick = true
	var joystick = JOYSTICK.instance()
	
	var _disable: bool = connect("joystick_disabled", joystick, "disable_joystick")
	joystick.connect("disabled", self, "on_joystick_disabled")
	joystick.touched = true
	
	add_child(joystick)
	
	joystick.global_position = spawn_position
	
	
func on_joystick_disabled() -> void:
	has_joystick = false
	
	
func on_slot_container_closed() -> void:
	has_joystick = false
