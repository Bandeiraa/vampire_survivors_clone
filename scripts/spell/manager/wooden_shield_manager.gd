extends SpellManager
class_name WoodenShieldManager

onready var pivot: Node2D = get_node("Pivot")

var is_active: bool = false
var avaliable_spawn_positions: Array = [
	Vector2(0, 32),
	Vector2(0, -32),
	Vector2(32, 0),
	Vector2(-32, 0)
]

func _ready() -> void:
	randomize()
	spell_level_dict = {
		1: {
			"spawn_amount": 1,
			"damage": [
				3,
				6
			],
			"rotation_speed": 3,
			"lifetime": 4.0,
			"spawn_cooldown": 8.0
		},
		
		2: {
			"spawn_amount": 1,
			"damage": [
				6,
				9
			],
			"rotation_speed": 3,
			"lifetime": 4.0,
			"spawn_cooldown": 8.0
		},
		
		3: {
			"spawn_amount": 2,
			"damage": [
				6,
				9
			],
			"rotation_speed": 3,
			"lifetime": 4.0,
			"spawn_cooldown": 8.0
		},
		
		4: {
			"spawn_amount": 2,
			"damage": [
				6,
				9
			],
			"rotation_speed": 6,
			"lifetime": 4.0,
			"spawn_cooldown": 8.0
		},
		
		5: {
			"spawn_amount": 2,
			"damage": [
				6,
				9
			],
			"rotation_speed": 6,
			"lifetime": 4.0,
			"spawn_cooldown": 4.0
		},
		
		6: {
			"spawn_amount": 2,
			"damage": [
				6,
				9
			],
			"rotation_speed": 6,
			"lifetime": 8.0,
			"spawn_cooldown": 4.0
		}
	}
	
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
	
	
func _process(delta) -> void:
	if not is_active:
		return
		
	pivot.rotation += delta * spell_level_dict[spell_level]["rotation_speed"]
	
	
func spawn() -> void:
	var spell: SpellTemplate = spell_to_instance.instance()
	var damage_list: Array = spell_level_dict[spell_level]["damage"]
	
	spell.min_damage = damage_list.min()
	spell.max_damage = damage_list.max()
	
	var random_index: int = randi() % avaliable_spawn_positions.size()
	var random_spawn_position: Vector2 = avaliable_spawn_positions[random_index]
	avaliable_spawn_positions.remove(random_index)
	
	spell.position = random_spawn_position
	pivot.add_child(spell)
	
	
func on_timer_timeout() -> void:
	if is_active:
		kill_shield()
		is_active = false
		timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
		return
		
	avaliable_spawn_positions = [Vector2(0, 32), Vector2(0, -32), Vector2(32, 0), Vector2(-32, 0)]
	
	for i in spell_level_dict[spell_level]["spawn_amount"]:
		spawn()
		
	is_active = true
	pivot.rotation = 0
	timer.start(spell_level_dict[spell_level]["lifetime"])
	
	
func kill_shield() -> void:
	for shield in pivot.get_children():
		shield.queue_free()
