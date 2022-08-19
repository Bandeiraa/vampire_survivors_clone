extends Node2D
class_name GameLevel

func _ready() -> void:
	get_tree().paused = false
	global_info.owner_ref = self
