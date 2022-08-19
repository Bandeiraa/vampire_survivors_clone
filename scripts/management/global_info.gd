extends Node
class_name GlobalInfo

var floating_text_scene: PackedScene = preload("res://scenes/management/floating_text.tscn")

var max_spell: int = 3
var unlocked_spell: int = 1

var joystick = null
var joystick_velocity: Vector2 = Vector2.RIGHT

var character: CharacterTemplate = null

var spell_dict: Dictionary = {
	"Dagger": {
		1: "Unlock Dagger",
		2: "Spawn Cooldown: -0.3s",
		3: "Base Damage: +3",
		4: "Spawn Cooldown: -0.3s",
		5: "Base Damage: +3",
		6: "Spawn Cooldown: -0.7s",
		
		"texture_path": preload("res://assets/spell/dagger.png"),
		"spell_scene": preload("res://scenes/spell/manager/dagger_manager.tscn"),
		
		"max_level": false,
		"current_level": 0
	},
	
	"Sword": {
		1: "Unlock Sword",
		2: "Spawn Cooldown: -0.5s",
		3: "Spawn Cooldown: -0.5s",
		4: "Spawn Amount: +1",
		5: "Spawn Cooldown: -1.0s",
		6: "Base Damage: +10",
		
		"texture_path": preload("res://assets/spell/sword.png"),
		"spell_scene": preload("res://scenes/spell/manager/sword_manager.tscn"),
		
		"max_level": false,
		"current_level": 0
	},
	
	"Lava Floor": {
		1: "Unlock Lava Floor",
		2: "Base Damage: +3",
		3: "Hit Cooldown: -0.8s",
		4: "Spawn Cooldown: -2.0s",
		5: "Spawn Cooldown: -2.0s",
		6: "Lifetime: +6.0s",
		
		"texture_path": preload("res://assets/spell/lava_potion.png"),
		"spell_scene": preload("res://scenes/spell/manager/lava_spell_manager.tscn"),
		
		"max_level": false,
		"current_level": 0
	},
	
	"Wooden Shield": {
		1: "Unlock Wooden Shield",
		2: "Base Damage: +3",
		3: "Spawn Amount: +1",
		4: "Rotation Speed: x2",
		5: "Spawn Cooldown: -4.0s",
		6: "Lifetime: +4.0s",
		
		"texture_path": preload("res://assets/spell/wooden_shield.png"),
		"spell_scene": preload("res://scenes/spell/manager/wooden_shield_manager.tscn"),
		
		"max_level": false,
		"current_level": 0
	},
	
	"Iron Shield": {
		1: "Unlock Iron Shield",
		2: "Base Damage: +3",
		3: "Spawn Cooldown: -2.0s",
		4: "Base Damage: +3",
		5: "Spawn Cooldown: -2.0s",
		6: "Base Damage: +3",
		
		"texture_path": preload("res://assets/spell/iron_shield.png"),
		"spell_scene": preload("res://scenes/spell/manager/iron_shield_manager.tscn"),
		
		"max_level": false,
		"current_level": 0
	}
}

func reset() -> void:
	for spell in spell_dict.keys():
		spell_dict[spell]["max_level"] = false
		spell_dict[spell]["current_level"] = 0
		
	joystick_velocity = Vector2.RIGHT
	
	
func spawn_floating_text(text: String, spawn_position: Vector2) -> void:
	var floating_text = floating_text_scene.instance()
	
	floating_text.new_text = text
	floating_text.global_position = spawn_position
	get_tree().root.call_deferred("add_child", floating_text)
