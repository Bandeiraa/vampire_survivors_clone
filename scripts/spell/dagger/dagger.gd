extends Area2D
class_name Dagger

var speed: int
var damage: int
 
var rotation_speed: int = 180

var direction: Vector2

func _ready() -> void:
	randomize()
	direction = Vector2(
		sign(rand_range(-1, 1)),
		sign(rand_range(1, -1))
	)
	
	
func _physics_process(delta: float) -> void:
	translate(delta * speed * direction)
	rotation_degrees += delta * rotation_speed
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func on_area_entered(_area) -> void:
	pass
