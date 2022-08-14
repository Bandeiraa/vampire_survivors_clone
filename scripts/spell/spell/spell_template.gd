extends Area2D
class_name SpellTemplate

var speed: int
var damage: int
var rotation_speed: int = 180

var direction: Vector2

export(bool) var can_kill = true
export(bool) var can_move = true
export(bool) var can_rotate = true

func _physics_process(delta: float) -> void:
	if can_move:
		translate(delta * speed * direction.normalized())
		
	if can_rotate:
		rotation_degrees += delta * rotation_speed
		
		
func on_area_entered(area) -> void:
	if area is EnemyTemplate:
		area.update_health(damage)
		
		
func on_screen_exited() -> void:
	if can_kill:
		queue_free()
