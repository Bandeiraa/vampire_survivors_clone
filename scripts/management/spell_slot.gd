extends VBoxContainer
class_name SpellSlot

signal clicked

onready var spell_name: Label = get_node("SpellName")
onready var spell_buff: Label = get_node("SpellBuff")
onready var spell_texture: TextureRect = get_node("SpellTexture/ContainerBackground/SpellTexture")

var can_click: bool = false

func _ready() -> void:
	var _exited: bool = connect("mouse_exited", self, "mouse_interaction", ["exited"])
	var _entered: bool = connect("mouse_entered", self, "mouse_interaction", ["entered"])
	
	
func mouse_interaction(state: String) -> void:
	match state:
		"entered":
			can_click = true
			modulate.a = 0.5
			
		"exited":
			can_click = false
			modulate.a = 1.0
			
			
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_click") and can_click:
		emit_signal("clicked")
