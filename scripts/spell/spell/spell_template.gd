extends Area2D
class_name SpellTemplate

var speed: int
var damage: int
var rotation_speed: int = 180

var direction: float

export(bool) var can_move = true
export(bool) var can_rotate = true

func _physics_process(delta: float) -> void:
	if can_move:
		translate(Vector2(delta * speed * direction, 0))
		
	if can_rotate:
		rotation_degrees += delta * rotation_speed
		
		
func on_area_entered(area) -> void:
	if area is EnemyTemplate:
		area.update_health(damage)
		
		
func on_screen_exited() -> void:
	queue_free()
