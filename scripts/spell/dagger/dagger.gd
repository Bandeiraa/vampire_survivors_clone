extends Area2D
class_name Dagger

var speed: int
var damage: int
 
var rotation_speed: int = 180

var direction: Vector2

var direction_list: Array = [
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2.UP,
	Vector2.DOWN,
	Vector2.ONE,
	Vector2(-1, 1),
	Vector2(1, -1)
]

func _ready() -> void:
	randomize()
	direction = direction_list[randi() % direction_list.size()].normalized()
	
	
func _physics_process(delta: float) -> void:
	translate(delta * speed * direction)
	rotation_degrees += delta * rotation_speed
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func on_area_entered(_area) -> void:
	pass
