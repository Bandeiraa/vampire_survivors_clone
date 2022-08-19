extends SpellTemplate
class_name LavaFloor

onready var lifetime: Timer = get_node("Lifetime")
onready var attack_cooldown: Timer = get_node("AttackCooldown")

onready var collision: CollisionShape2D = get_node("Collision")
onready var sprite: Sprite = get_node("Texture")

var hit_cooldown: float
var lifetime_cooldown: float

var areas_in_range: Array

var direction_list: Array = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

export(StreamTexture) var lava_floor

func _ready() -> void:
	direction = direction_list[randi() % direction_list.size()]
	
	
func _physics_process(delta: float) -> void:
	if can_move:
		translate(delta * speed * direction)
		
	if can_rotate:
		rotation_degrees += delta * rotation_speed
		
		
func on_area_entered(area) -> void:
	if area.name == "Hitbox":
		var random_damage: int = int(rand_range(min_damage, max_damage))
		global_info.update_stats(random_damage, weapon_dict_key)
		area.get_parent().update_health(random_damage)
		areas_in_range.append(area)
		
		
func on_area_exited(area) -> void:
	if not (area.name == "Hitbox"):
		return
		
	var index: int = areas_in_range.find(area)
	if index == -1:
		return
		
	areas_in_range.remove(index)
	
	
func on_attack_cooldown_timeout() -> void:
	for area in areas_in_range:
		var random_damage: int = int(rand_range(min_damage, max_damage))
		area.get_parent().update_health(random_damage)
		
		
func on_throw_lifetime_timeout() -> void:
	can_move = false
	can_rotate = false
	
	collision.disabled = false
	sprite.texture = lava_floor
	lifetime.start(lifetime_cooldown)
	attack_cooldown.start(hit_cooldown)
	
	
func on_lifetime_timeout() -> void:
	queue_free()
