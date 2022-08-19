extends SpellManager
class_name IronShieldManager

func _ready() -> void:
	randomize()
	spell_level_dict = {
		1: {
			"spawn_amount": 1,
			"damage": [
				5,
				10
			],
			"move_speed": 120,
			"spawn_cooldown": 12.0
		},
		
		2: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 120,
			"spawn_cooldown": 12.0
		},
		
		3: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 120,
			"spawn_cooldown": 10.0
		},
		
		4: {
			"spawn_amount": 1,
			"damage": [
				11,
				16
			],
			"move_speed": 120,
			"spawn_cooldown": 10.0
		},
		
		5: {
			"spawn_amount": 1,
			"damage": [
				11,
				16
			],
			"move_speed": 120,
			"spawn_cooldown": 8.0
		},
		
		6: {
			"spawn_amount": 1,
			"damage": [
				14,
				19
			],
			"move_speed": 120,
			"spawn_cooldown": 8.0
		}
	}
	
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
	
	
func spawn() -> void:
	var spell: SpellTemplate = spell_to_instance.instance()
	var damage_list: Array = spell_level_dict[spell_level]["damage"]
	
	spell.speed = spell_level_dict[spell_level]["move_speed"]
	
	var direction_list: Array = [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT
	]
	
	var move_direction: Vector2 = direction_list[randi() % direction_list.size()]
	
	spell.direction = move_direction
	spell.min_damage = damage_list.min()
	spell.max_damage = damage_list.max()
	
	spell.global_position = global_position
	get_tree().root.call_deferred("add_child", spell)
