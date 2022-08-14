extends Area2D
class_name Dagger

var speed: int
var damage: int
 
var rotation_speed: int = 180

var direction: float

func _physics_process(delta: float) -> void:
	translate(Vector2(delta * speed * direction, 0))
	rotation_degrees += delta * rotation_speed
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func on_area_entered(area) -> void:
	if area is EnemyTemplate:
		area.update_health(damage)
