extends Node2D
class_name FloatingText

onready var label: Label = get_node("Text")
onready var tween: Tween = get_node("Tween")

var new_text: String

func _ready() -> void:
	interpolate_text()
	
	
func interpolate_text() -> void:
	label.text = new_text
	
	var _modulate_down: bool = tween.interpolate_property(
		self,
		"modulate:a",
		1.0,
		0.0,
		0.2,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT,
		0.4
	)
	
	var _start: bool = tween.start()
	
	
func _process(delta) -> void:
	position.y += delta * 20
	
	
func on_tween_finished() -> void:
	queue_free()
