extends SpellTemplate
class_name Sword

var direction_list: Array = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

func _ready() -> void:
	direction = direction_list[randi() % direction_list.size()]
