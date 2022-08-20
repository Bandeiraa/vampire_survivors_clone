extends KinematicBody2D
class_name EnemyTemplate

const EXP_ORB: PackedScene = preload("res://scenes/environment/exp_orb.tscn")
const HEALTH_POTION: PackedScene = preload("res://scenes/environment/health_potion.tscn")

onready var sprite: Sprite = get_node("Texture")

onready var timer: Timer = get_node("AttackTimer")
onready var hit_timer: Timer = get_node("HitTimer")

onready var animation: AnimationPlayer = get_node("Animation")

var can_attack: bool = true

var health: int
var experience: int

var distance: float

var velocity: Vector2
var direction: Vector2

export(bool) var can_apply_outline = true

export(int) var speed
export(int) var distance_threshold

export(int) var min_health
export(int) var max_health

export(int) var attack_damage

export(int) var min_exp
export(int) var max_exp

export(float) var attack_cooldown
export(float) var spawn_potion_threshold

func _ready() -> void:
	randomize()
	experience = int(round(rand_range(min_exp, max_exp)))
	health = int(round(rand_range(min_health, max_health)))
	
	if can_apply_outline:
		set_random_outline_color()
		
		
func set_random_outline_color() -> void:
	var random_color: Color = Color(randf(), randf(), randf(), 1.0)
	
	sprite.material.set("shader_param/line_color", random_color)
	sprite.material.set("shader_param/can_apply_outline", can_apply_outline)
	
	
func _physics_process(_delta: float) -> void:
	direction = global_position.direction_to(global_info.character.global_position) 
	distance = global_position.distance_to(global_info.character.global_position)
	if distance < distance_threshold and can_attack:
		attack()
		
	if distance < distance_threshold:
		return
		
		
	velocity = direction * speed
	velocity = move_and_slide(velocity)
	
	
func attack() -> void:
	global_info.character.update_health("decrease", attack_damage)
	timer.start(attack_cooldown)
	can_attack = false
	
	
func update_health(damage: int) -> void:
	health -= damage
	global_info.spawn_floating_text(str(damage), global_position)
	
	if health <= 0:
		global_info.stats_info["kill_count"] += 1
		spawn_health_potion()
		spawn_exp_orb()
		queue_free()
		
	sprite.material.set("shader_param/active", true)
	hit_timer.start()
	
	
func on_attack_timer_timeout() -> void:
	can_attack = true
	
	
func on_hit_timer_timeout() -> void:
	sprite.material.set("shader_param/active", false)
	
	
func spawn_health_potion() -> void:
	var random_f: float = randf()
	if random_f < spawn_potion_threshold:
		var health_potion = HEALTH_POTION.instance()
		health_potion.global_position = global_position
		global_info.owner_ref.call_deferred("add_child", health_potion)
		
		
func spawn_exp_orb() -> void:
	var exp_orb = EXP_ORB.instance()
	
	exp_orb.experience = experience
	exp_orb.global_position = global_position
	global_info.owner_ref.call_deferred("add_child", exp_orb)
