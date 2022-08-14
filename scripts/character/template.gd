extends KinematicBody2D
class_name CharacterTemplate

onready var sprite: Sprite = get_node("Texture")

var velocity: Vector2

var direction: int = 1 
var last_flipped_state: int = 1

export(int) var move_speed

func _ready() -> void:
	global_info.character = self
	
	
func _physics_process(_delta: float) -> void:
	move()
	direction = get_orientation()
	velocity = move_and_slide(velocity)
	
	
func move() -> void:
	velocity = get_direction() * move_speed
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	
func get_orientation() -> int:
	if velocity.x > 0:
		sprite.flip_h = false
		last_flipped_state = 1
		return 1
		
	if velocity.x < 0:
		sprite.flip_h = true
		last_flipped_state = -1
		return -1
		
	return last_flipped_state
