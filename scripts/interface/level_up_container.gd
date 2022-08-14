extends Control
class_name LevelUpContainer

onready var spell_container: HBoxContainer = get_node("BackgroundTexture/HContainer")

func _ready() -> void:
	for spell_slot in spell_container.get_children():
		spell_slot.connect("clicked", self, "on_slot_clicked")
		
		
func on_slot_clicked() -> void:
	get_tree().paused = false
	queue_free()
