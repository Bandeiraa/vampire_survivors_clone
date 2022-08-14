extends SpellManager
class_name LavaSpellManager

func _ready() -> void:
	spell_level_dict = {
		1: {
			"spawn_amount": 1,
			"damage": [
				5,
				10
			],
			"move_speed": 30,
			"hit_cooldown": 2.0,
			"spawn_cooldown": 8.0,
			"lifetime_cooldown": 6.0
		},
		
		2: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 30,
			"hit_cooldown": 2.0,
			"spawn_cooldown": 8.0,
			"lifetime_cooldown": 6.0
		},
		
		3: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 30,
			"hit_cooldown": 1.2,
			"spawn_cooldown": 8.0,
			"lifetime_cooldown": 6.0
		},
		
		4: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 30,
			"hit_cooldown": 1.2,
			"spawn_cooldown": 6.0,
			"lifetime_cooldown": 6.0
		},
		
		5: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 30,
			"hit_cooldown": 1.2,
			"spawn_cooldown": 6.0,
			"lifetime_cooldown": 6.0
		},
		
		6: {
			"spawn_amount": 1,
			"damage": [
				8,
				13
			],
			"move_speed": 30,
			"hit_cooldown": 1.2,
			"spawn_cooldown": 6.0,
			"lifetime_cooldown": 12.0
		}
	}
	
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
	
	
func spawn() -> void:
	var spell: SpellTemplate = spell_to_instance.instance()
	var damage_list: Array = spell_level_dict[spell_level]["damage"]
	
	spell.hit_cooldown = spell_level_dict[spell_level]["hit_cooldown"]
	spell.lifetime_cooldown = spell_level_dict[spell_level]["lifetime_cooldown"]
	
	spell.speed = spell_level_dict[spell_level]["move_speed"]
	spell.damage = int(rand_range(damage_list.min(), damage_list.max()))
	
	spell.global_position = global_position
	get_tree().root.call_deferred("add_child", spell)
