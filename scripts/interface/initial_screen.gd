extends Control
class_name InitialScreen

onready var shadow: VBoxContainer = get_node("Shadow")
onready var v_container: VBoxContainer = get_node("VContainer")

func _ready() -> void:
	get_tree().paused = false
	
	for button in shadow.get_children():
		button.connect("mouse_exited", self, "mouse_interaction", ["exited", button])
		button.connect("mouse_entered", self, "mouse_interaction", ["entered", button])
		
	for button in v_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button])
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
		"Play":
			var _change_scene: bool = get_tree().change_scene("res://scenes/management/game_level.tscn")
			
		"Quit":
			get_tree().quit()
