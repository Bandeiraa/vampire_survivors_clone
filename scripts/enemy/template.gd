extends Area2D
class_name EnemyTemplate

onready var timer: Timer = get_node("AttackTimer")
onready var animation: AnimationPlayer = get_node("Animation")

var can_attack: bool = true

var health: int
var experience: int

var distance: float
var direction: Vector2

export(int) var speed
export(int) var distance_threshold

export(int) var min_health
export(int) var max_health

export(int) var attack_damage

export(int) var min_exp
export(int) var max_exp

export(float) var attack_cooldown

func _ready() -> void:
	randomize()
	experience = int(rand_range(min_exp, max_exp))
	health = int(rand_range(min_health, max_health))
	
	
func _physics_process(delta: float) -> void:
	direction = global_position.direction_to(global_info.character.global_position) 
	distance = global_position.distance_to(global_info.character.global_position)
	if distance < distance_threshold and can_attack:
		attack()
		
	if distance < distance_threshold:
		return
		
	translate(direction * speed * delta)
	
	
func attack() -> void:
	global_info.character.update_health(attack_damage)
	timer.start(attack_cooldown)
	can_attack = false
	
	
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		global_info.character.update_exp(experience)
		queue_free()
		
	animation.play("hit")
	
	
func on_attack_timer_timeout() -> void:
	can_attack = true
