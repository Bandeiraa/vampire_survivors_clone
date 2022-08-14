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
			"spawn_amount": 2,
			"damage": [
				5,
				10
			],
			"move_speed": 90,
			"spawn_cooldown": 2.2
		},
		
		4: {
			"spawn_amount": 2,
			"damage": [
				8,
				13
			],
			"move_speed": 90,
			"spawn_cooldown": 2.2
		},
		
		5: {
			"spawn_amount": 2,
			"damage": [
				8,
				13
			],
			"move_speed": 120,
			"spawn_cooldown": 2.2
		},
		
		6: {
			"spawn_amount": 3,
			"damage": [
				5,
				10
			],
			"move_speed": 120,
			"spawn_cooldown": 2.2
		}
	}
	
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
	
	
func spawn() -> void:
	var spell: Dagger = spell_to_instance.instance()
	var damage_list: Array = spell_level_dict[spell_level]["damage"]
	
	spell.direction = global_info.character.direction
	spell.speed = spell_level_dict[spell_level]["move_speed"]
	spell.damage = int(rand_range(damage_list.min(), damage_list.max()))
	
	spell.global_position = global_position
	get_tree().root.call_deferred("add_child", spell)
