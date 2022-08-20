extends CanvasLayer
class_name GameOverScreen

onready var shadow: HBoxContainer = get_node("Control/Shadow")
onready var button_container: HBoxContainer = get_node("Control/HContainer")
onready var v_container: VBoxContainer = get_node("Control/Container/VContainer")

func _ready() -> void:
	update_game_over_info()
	
	for button in button_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", ["exited", button])
		button.connect("mouse_entered", self, "mouse_interaction", ["entered", button])
		
	for button in shadow.get_children():
		button.connect("mouse_exited", self, "mouse_interaction", ["exited", button])
		button.connect("mouse_entered", self, "mouse_interaction", ["entered", button])
		
		
func mouse_interaction(state: String, button: Button) -> void:
	match state:
		"entered":
			button.modulate.a = 0.5
			
		"exited":
			button.modulate.a = 1.0
			
			
func on_button_pressed(button: Button) -> void:
	match button.name:
		"MenuButton":
			global_info.reset()
			var _change_scene: bool = get_tree().change_scene("res://scenes/interface/initial_screen.tscn")
			
		"ReloadButton":
			global_info.reset()
			var _reload: bool = get_tree().change_scene("res://scenes/management/game_level.tscn")
			
		"QuitButton":
			get_tree().quit()
			
			
func update_game_over_info() -> void:
	var keys_list: Array = []
	for key in global_info.stats_info.keys():
		keys_list.append(key)
		
	for i in v_container.get_children().size():
		var child_label: Label = v_container.get_child(i)
		child_label.text = child_label.text + " " + str(global_info.stats_info[keys_list[i]])
