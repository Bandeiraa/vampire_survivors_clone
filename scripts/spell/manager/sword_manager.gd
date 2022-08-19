extends SpellManager
class_name SwordManager

var move_direction: Vector2

func _ready() -> void:
	randomize()
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
	
	spell.direction = move_direction
	spell.min_damage = damage_list.min()
	spell.max_damage = damage_list.max()
	
	spell.global_position = global_position
	get_tree().root.call_deferred("add_child", spell)
	var _kill: bool = global_info.character.connect("game_over", spell, "queue_free")
	
	
func on_timer_timeout() -> void:
	var direction_list: Array = [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT
	]
	
	for i in spell_level_dict[spell_level]["spawn_amount"]:
		var random_index: int = randi() % direction_list.size()
		move_direction = direction_list[random_index]
		direction_list.remove(random_index)
		spawn()
		
	timer.start(spell_level_dict[spell_level]["spawn_cooldown"])
