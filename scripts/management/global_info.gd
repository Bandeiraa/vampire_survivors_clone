extends Node
class_name GlobalInfo

var max_spell: int = 3
var unlocked_spell: int = 1

var character: CharacterTemplate = null

var spell_dict: Dictionary = {
	"Dagger": {
		1: "Unlock Dagger",
		2: "Spawn Cooldown: -0.3s",
		3: "Spawn Amount: +1",
		4: "Base Damage: +3",
		5: "Move Speed: +30",
		6: "Spawn Amount: +1",
		
		"texture_path": "res://assets/spell/dagger.png",
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
		
		"texture_path": "res://assets/spell/sword.png",
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
		
		"texture_path": "res://assets/spell/lava_potion.png",
		"max_level": false,
		"current_level": 0
	}
}
