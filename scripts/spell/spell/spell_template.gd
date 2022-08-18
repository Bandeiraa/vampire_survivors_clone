extends Area2D
class_name SpellTemplate

var speed: int

var min_damage: int
var max_damage: int

var rotation_speed: int = 180

var direction: Vector2

export(bool) var can_kill = true
export(bool) var can_move = true
export(bool) var can_rotate = true

func _ready() -> void:
	randomize()
	
	 
func _physics_process(delta: float) -> void:
	if can_move:
		translate(delta * speed * direction.normalized())
		
	if can_rotate:
		rotation_degrees += delta * rotation_speed
		
		
func on_area_entered(area) -> void:
	if area.name == "Hitbox":
		var random_damage: int = int(rand_range(min_damage, max_damage))
		area.get_parent().update_health(random_damage)
		
		
func on_screen_exited() -> void:
	if can_kill:
		queue_free()
