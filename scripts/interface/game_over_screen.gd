extends CanvasLayer
class_name GameOverScreen

onready var shadow: HBoxContainer = get_node("Control/Shadow")
onready var button_container: HBoxContainer = get_node("Control/HContainer")

func _ready() -> void:
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
			pass
			
		"ReloadButton":
			global_info.reset()
			var _reload: bool = get_tree().change_scene("res://scenes/management/game_level.tscn")
			
		"QuitButton":
			get_tree().quit()
