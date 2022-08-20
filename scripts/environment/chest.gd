extends Area2D
class_name Chest

onready var sprite: Sprite = get_node("Texture")

onready var epic_chest: StreamTexture = preload("res://assets/environment/epic_chest.png")
onready var normal_chest: StreamTexture = preload("res://assets/environment/normal_chest.png")

func set_texture(type: String) -> void:
	match type:
		"normal":
			sprite.texture = normal_chest
			
		"epic":
			sprite.texture = epic_chest
			
			
func on_body_entered(_body) -> void:
	queue_free()
