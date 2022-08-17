extends SpellManager
class_name DaggerManager

func _ready() -> void:
	spell_level_dict = {
		1: {
			"spawn_amount": 1,
			"damage": [
				5,
				10
			],
			"move_speed": 90,
			"spawn_cooldown": 2.5
		},
		
		2: {
			"spawn_amount": 1,
			"damage": [
				5,
				10
			],
			"move_speed": 90,
			"spawn_cooldown": 2.2
		},
		
		3: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 90,
			"spawn_cooldown": 2.2
		},
		
		4: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 90,
			"spawn_cooldown": 1.9
		},
		
		5: {
			"spawn_amount": 1,
			"damage": [
				11,
				16
			],
			"move_speed": 90,
			"spawn_cooldown": 1.9
		},
		
		6: {
			"spawn_amount": 1,
			"damage": [
				11,
				16
			],
			"move_speed": 90,
			"spawn_cooldown": 1.2
		}
	}
	
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
	
	
func spawn() -> void:
	var spell: SpellTemplate = spell_to_instance.instance()
	var damage_list: Array = spell_level_dict[spell_level]["damage"]
	
	#spell.direction = Vector2(global_info.character.direction, 0)
	spell.direction = global_info.joystick_velocity
	spell.speed = spell_level_dict[spell_level]["move_speed"]
	
	spell.min_damage = damage_list.min()
	spell.max_damage = damage_list.max()
	
	spell.global_position = global_position
	get_tree().root.call_deferred("add_child", spell)
