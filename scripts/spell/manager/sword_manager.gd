extends SpellManager
class_name SwordManager

func _ready() -> void:
	spell_level_dict = {
		1: {
			"spawn_amount": 1,
			"damage": [
				10,
				15
			],
			"move_speed": 120,
			"spawn_cooldown": 4.0
		},
		
		2: {
			"spawn_amount": 1,
			"damage": [
				10,
				15
			],
			"move_speed": 120,
			"spawn_cooldown": 3.5
		},
		
		3: {
			"spawn_amount": 1,
			"damage": [
				10,
				15
			],
			"move_speed": 120,
			"spawn_cooldown": 3.0
		},
		
		4: {
			"spawn_amount": 2,
			"damage": [
				10,
				15
			],
			"move_speed": 120,
			"spawn_cooldown": 3.0
		},
		
		5: {
			"spawn_amount": 2,
			"damage": [
				10,
				15
			],
			"move_speed": 120,
			"spawn_cooldown": 2.0
		},
		
		6: {
			"spawn_amount": 2,
			"damage": [
				20,
				30
			],
			"move_speed": 120,
			"spawn_cooldown": 2.0
		}
	}
	
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
	
	
func spawn() -> void:
	var spell: SpellTemplate = spell_to_instance.instance()
	var damage_list: Array = spell_level_dict[spell_level]["damage"]
	
	spell.speed = spell_level_dict[spell_level]["move_speed"]
	spell.damage = int(rand_range(damage_list.min(), damage_list.max()))
	
	spell.global_position = global_position
	get_tree().root.call_deferred("add_child", spell)
