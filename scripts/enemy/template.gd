extends Area2D
class_name EnemyTemplate

var health: int
var direction: Vector2

export(int) var speed
export(int) var min_health
export(int) var max_health

func _ready() -> void:
	randomize()
	health = int(rand_range(min_health, max_health))
	
	
func _physics_process(delta: float) -> void:
	direction = global_position.direction_to(global_info.character.global_position) 
	translate(direction * speed * delta)
	
	
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()
