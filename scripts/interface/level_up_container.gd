extends Control
class_name LevelUpContainer

signal close_slot_container

onready var spell_container: VBoxContainer = get_node("BackgroundTexture/VContainer")
onready var aux_v_box: VBoxContainer = get_node("AuxVBox")

func _ready() -> void:
	randomize()
	
	for button in aux_v_box.get_children():
		button.connect("pressed", self, "on_button_pressed", [button.name])
		
	var avaliable_spell_list: Array = key_list()
	if avaliable_spell_list.empty():
		on_slot_clicked()
		
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
		if spell_dict[key]["max_level"]:
			continue
			
		aux_list.append([key, spell_dict[key]])
		
	return aux_list
	
	
func on_slot_clicked() -> void:
	emit_signal("close_slot_container")
	get_tree().paused = false
	queue_free()
	
	
func on_button_pressed(button_name: String) -> void:
	var target_slot: VBoxContainer = spell_container.get_node(button_name)
	if target_slot.visible:
		target_slot.button_clicked()
