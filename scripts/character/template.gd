extends KinematicBody2D
class_name CharacterTemplate

onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

onready var skill_list: Node2D = get_node("Skill")
onready var initial_skill: Node2D = skill_list.get_child(0)

var velocity: Vector2

var level: int = 1
var experience: int = 0
var total_experience: int = 0
var experience_required: int = get_required_experience(level + 1)

var direction: int = 1 
var last_flipped_state: int = 1

export(int) var health
export(int) var move_speed

func _ready() -> void:
	global_info.character = self
	global_info.spell_dict[initial_skill.spell_name]["current_level"] += 1
	get_tree().call_group("interface", "update_exp", level, experience, experience_required)
	
	
func _physics_process(_delta: float) -> void:
	move()
	direction = get_orientation()
	velocity = move_and_slide(velocity)
	
	
func move() -> void:
	velocity = get_direction() * move_speed
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	
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
	health -= damage
	if health <= 0:
		var _reload: bool = get_tree().change_scene("res://scenes/management/game_level.tscn")
		return
		
	animation.play("hit")
	
	
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
	
	
func get_required_experience(character_level: int) -> int:
	return int(round(pow(character_level, 1.8) + character_level * 4))
	
	
func update_spell_level(spell_name: String) -> void:
	for children in skill_list.get_children():
		if children.spell_name == spell_name:
			children.spell_level += 1
			
			
func send_spell(spell_scene) -> void:
	skill_list.add_child(spell_scene.instance())
