extends Area2D
class_name Joystick

signal disabled

onready var background: Sprite = get_node("Background")
onready var collision: CollisionShape2D = get_node("Collision")
onready var foreground: Sprite = background.get_node("Foreground")

onready var max_distance: float = collision.shape.radius

var touched: bool = false
var joystick_velocity: Vector2

func _input(event) -> void:
	if not event is InputEventScreenTouch:
		return
		
	var distance = event.position.distance_to(background.global_position)
	if touched:
		foreground.position = Vector2.ZERO
		touched = false
		return
		
	if distance < max_distance:
		touched = true
		
		
func _process(_delta) -> void:
	if not touched:
		global_info.character.update_velocity(Vector2.ZERO)
		emit_signal("disabled")
		queue_free()
		return
		
	foreground.global_position = get_global_mouse_position()
	foreground.position = background.position + (foreground.position - background.position).limit_length(max_distance)
	joystick_velocity = (foreground.position).normalized()
	global_info.joystick_velocity = joystick_velocity
	global_info.character.update_velocity(joystick_velocity)
