extends Control
class_name LevelUpContainer

onready var spell_container: HBoxContainer = get_node("BackgroundTexture/HContainer")

func _ready() -> void:
	randomize()
	var avaliable_spell_list: Array = key_list()
	for spell_slot in spell_container.get_children():
		spell_slot.connect("clicked", self, "on_slot_clicked")
		
		if avaliable_spell_list.empty():
			continue
			
		var random_index: int = randi() % avaliable_spell_list.size()
		spell_slot.populate_slot(avaliable_spell_list[random_index])
		avaliable_spell_list.remove(random_index)
		
		
func key_list() -> Array:
	var aux_list: Array = []
	var spell_dict: Dictionary = global_info.spell_dict
	
	for key in spell_dict.keys():
		if spell_dict[key].max_level:
			continue
			
		aux_list.append([key, spell_dict[key]])
		
	return aux_list
	
	
func on_slot_clicked() -> void:
	get_tree().paused = false
	queue_free()
