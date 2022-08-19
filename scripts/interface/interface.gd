extends CanvasLayer
class_name Interface

const JOYSTICK: PackedScene = preload("res://scenes/management/joystick.tscn")
const LEVEL_UP_SCENE: PackedScene = preload("res://scenes/interface/level_up_container.tscn")

onready var mask: Sprite = get_node("Mask")
onready var mask_animation: AnimationPlayer = mask.get_node("Animation")

onready var experience: Control = get_node("ExpContainer")

var has_joystick: bool = false
var wait_for_idle_frame: bool = false

func init_exp_bar(current_level: int, current_exp: int, target_exp: int) -> void:
	experience.init_bar(current_level, current_exp, target_exp)
	
	
func update_exp(current_level: int, current_exp: int, target_exp: int) -> void:
	experience.update_exp(current_level, current_exp, target_exp)
	
	
func spawn_level_up_container() -> void:
	if is_instance_valid(global_info.joystick):
		global_info.joystick.queue_free()
		
	var level_up_scene = LEVEL_UP_SCENE.instance()
	level_up_scene.connect("close_slot_container", self, "on_slot_container_closed")
	add_child(level_up_scene)
	
	
func _input(event) -> void:
	if wait_for_idle_frame and OS.get_name() == "Android":
		wait_for_idle_frame = false
		return
		
	if event is InputEventScreenTouch and not has_joystick:
		spawn_joystick(event.position)
		
		
func spawn_joystick(spawn_position: Vector2) -> void:
	has_joystick = true
	var joystick = JOYSTICK.instance()
	
	joystick.connect("disabled", self, "on_joystick_disabled")
	joystick.touched = true
	
	joystick.global_position = spawn_position
	global_info.joystick = joystick
	add_child(joystick)
	
	
func on_joystick_disabled() -> void:
	has_joystick = false
	
	
func on_slot_container_closed() -> void:
	has_joystick = false
	wait_for_idle_frame = true
	global_info.character.start_invincibility_timer()
	
	
func apply_mask_shader() -> void:
	get_tree().paused = true
	
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var screenshot = ImageTexture.new()
	screenshot.create_from_image(img)
	mask.texture = screenshot
	
	mask_animation.play("apply_pixelation")
