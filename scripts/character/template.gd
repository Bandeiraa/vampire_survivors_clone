extends KinematicBody2D
class_name CharacterTemplate

var velocity: Vector2

export(int) var move_speed

func _physics_process(_delta: float) -> void:
	move()
	velocity = move_and_slide(velocity)
	
	
func move() -> void:
	velocity = get_direction() * move_speed
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
