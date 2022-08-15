extends TextureRect
class_name HealthBar

onready var tween: Tween = get_node("Tween")
onready var bar: TextureProgress = get_node("Bar")

var current_value: int

func init_bar(max_value: int) -> void:
	current_value = max_value
	bar.max_value = max_value
	bar.value = max_value
	
	
func update_bar(new_value: int) -> void:
	interpolate_health(current_value, new_value)
	current_value = new_value
	
	
func interpolate_health(old_value: int, new_value: int) -> void:
	var _interpolate: bool = tween.interpolate_property(
		bar,
		"value",
		old_value,
		new_value,
		0.2
	)
	
	var _start: bool = tween.start()
