extends KinematicBody2D
class_name CharacterTemplate

onready var invincibility_timer: Timer = get_node("InvincibilityTimer")
onready var hit_timer: Timer = get_node("HitTimer")

onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")
onready var bar: TextureRect = get_node("HealthBarBackground")

onready var skill_list: Node2D = get_node("Skill")
onready var initial_skill: Node2D = skill_list.get_child(0)

var velocity: Vector2

var is_invincible: bool = false

var level: int = 1
var experience: int = 0
var total_experience: int = 0
var experience_required: int = get_required_experience(level + 1)

var direction: int = 1 
var last_flipped_state: int = 1

export(int) var health
export(int) var move_speed

func _ready() -> void:
	bar.init_bar(health)
	global_info.character = self
	global_info.spell_dict[initial_skill.spell_name]["current_level"] += 1
	get_tree().call_group("interface", "init_exp_bar", level, experience, experience_required)
	
	
func update_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity * move_speed
	if velocity == Vector2.ZERO:
		animation.play("idle")
		
	if velocity != Vector2.ZERO:
		animation.play("move")
		
	direction = get_orientation()
	velocity = move_and_slide(velocity)
	
	
func get_orientation() -> int:
	if velocity.x > 0:
		sprite.flip_h = false
		last_flipped_state = 1
		return 1
		
	if velocity.x < 0:
		sprite.flip_h = true
		last_flipped_state = -1
		return -1
		
	return last_flipped_state
	
	
func update_health(damage: int) -> void:
	if is_invincible:
		return
		
	health -= damage
	bar.update_bar(health)
	
	if health <= 0:
		global_info.reset()
		var _reload: bool = get_tree().change_scene("res://scenes/management/game_level.tscn")
		return
		
	sprite.material.set("shader_param/active", true)
	hit_timer.start()
	
	
func update_exp(value: int) -> void:
	total_experience += value
	experience += value
	while experience >= experience_required:
		experience -= experience_required
		level_up()
		
	get_tree().call_group("interface", "update_exp", level, experience, experience_required)
	
	
func level_up() -> void:
	level += 1
	experience = 0
	experience_required = get_required_experience(level + 1)
	get_tree().call_group("interface", "spawn_level_up_container")
	get_tree().call_group("interface", "init_exp_bar", level, experience, experience_required)
	
	
func get_required_experience(character_level: int) -> int:
	return int(round(pow(character_level, 2.2) + character_level * 4))
	
	
func update_spell_level(spell_name: String) -> void:
	for children in skill_list.get_children():
		if children.spell_name == spell_name:
			children.spell_level += 1
			
			
func send_spell(spell_scene) -> void:
	skill_list.add_child(spell_scene.instance())
	
	
func start_invincibility_timer() -> void:
	is_invincible = true
	invincibility_timer.start(2.0)
	
	
func on_invincibility_timer_timeout() -> void:
	is_invincible = false
	
	
func on_hit_timer_timeout() -> void:
	sprite.material.set("shader_param/active", false)
