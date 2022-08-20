extends VBoxContainer
class_name SpellSlot

signal clicked

enum list_info {
	KEY,
	DICT
}

onready var spell_name: Label = get_node("SpellName")
onready var spell_buff: Label = get_node("SpellBuff")
onready var spell_texture: TextureRect = get_node("SpellTexture/ContainerBackground/SpellTexture")

var dict_key: String
var is_in_special_slot: bool = false

func populate_slot(spell_info: Array) -> void:
	
	show()
	
	var spell_dict: Dictionary = spell_info[list_info.DICT]
	var current_level: int = spell_dict["current_level"] + 1
	
	var _spell_texture: StreamTexture = spell_dict["texture_path"]
	var _spell_buff: String = spell_dict[current_level]
	var _spell_name: String = spell_info[list_info.KEY]
	
	dict_key = _spell_name
	
	spell_name.text = _spell_name + ", Level: " + str(current_level)
	spell_texture.texture = _spell_texture
	spell_buff.text = _spell_buff
	
	
func special_slot(spell_key: String, spell_info: Dictionary) -> void:
	is_in_special_slot = true
	
	show()
	
	spell_name.text = spell_key
	spell_buff.text = spell_info["effect"]
	spell_texture.texture = spell_info["texture_path"]
	
	
func button_clicked() -> void:
	emit_signal("clicked")
	if is_in_special_slot:
		global_info.character.update_health("increase", 30)
		return
		
	update_spell_level()
	
	
func update_spell_level() -> void:
	global_info.spell_dict[dict_key]["current_level"] += 1
	if global_info.spell_dict[dict_key]["current_level"] == 6:
		global_info.spell_dict[dict_key]["max_level"] = true
		
	get_tree().call_group("character", "update_spell_level", dict_key)
	
	if global_info.spell_dict[dict_key]["current_level"] == 1:
		get_tree().call_group("character", "send_spell", global_info.spell_dict[dict_key]["spell_scene"])
		return
