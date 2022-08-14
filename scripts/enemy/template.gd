extends Area2D
class_name EnemyTemplate

onready var animation: AnimationPlayer = get_node("Animation")

var health: int
var distance: float
var direction: Vector2

export(int) var speed
export(int) var min_health
export(int) var max_health
export(int) var distance_threshold

func _ready() -> void:
	randomize()
	health = int(rand_range(min_health, max_health))
	
	
func _physics_process(delta: float) -> void:
	direction = global_position.direction_to(global_info.character.global_position) 
	distance = global_position.distance_to(global_info.character.global_position)
	if distance < distance_threshold:
		return
		
	translate(direction * speed * delta)
	
	
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()
		
	animation.play("hit")
