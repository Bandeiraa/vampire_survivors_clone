extends Control
class_name LevelUpContainer

signal close_slot_container

onready var spell_container: VBoxContainer = get_node("BackgroundTexture/VContainer")
onready var aux_v_box: VBoxContainer = get_node("AuxVBox")

func _ready() -> void:
	randomize()
	get_tree().paused = true
	if is_instance_valid(global_info.joystick):
		global_info.joystick.queue_free()
		
	for button in aux_v_box.get_children():
		button.connect("pressed", self, "on_button_pressed", [button.name])
		
	var index: int = 0
	var avaliable_spell_list: Array = key_list()
	for spell_slot in spell_container.get_children():
		spell_slot.connect("clicked", self, "on_slot_clicked")
		
		if avaliable_spell_list.empty() and index == 0:
			spell_slot.special_slot("Potion", global_info.spell_dict["Potion"])
			return
			
		if avaliable_spell_list.empty():
			return
			
		var random_index: int = randi() % avaliable_spell_list.size()
		spell_slot.populate_slot(avaliable_spell_list[random_index])
		avaliable_spell_list.remove(random_index)
		index += 1
		
		
func key_list() -> Array:
	var aux_list: Array = []
	var spell_dict: Dictionary = global_info.spell_dict
	
	for key in spell_dict.keys():
		if key == "Potion" or spell_dict[key]["max_level"]:
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
		
		
func _process(_delta: float) -> void:
	if is_instance_valid(global_info.joystick):
		global_info.joystick.queue_free()
