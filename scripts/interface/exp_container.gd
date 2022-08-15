extends Control
class_name ExperienceContainer

onready var tween: Tween = get_node("Tween")
onready var exp_bar: TextureProgress = get_node("ExpBar")
onready var level_info: Label = exp_bar.get_node("Level")

var current_bar_value: int

func init_bar(level: int, current_exp: int, target_exp: int) -> void:
	current_bar_value = current_exp
	exp_bar.max_value = target_exp
	exp_bar.value = current_exp
	
	level_info.text = "Level: " + str(level) + " - Current Exp: " + str(current_exp) + "/" + str(target_exp) 
	
	
func update_exp(level: int, current_exp: int, target_exp: int) -> void:
	interpolate(level, target_exp, current_bar_value, current_exp)
	current_bar_value = current_exp
	
	
func interpolate(level: int, target_exp: int, old_value: int, new_value: int) -> void:
	var _interpolate: bool = tween.interpolate_property(
		exp_bar,
		"value",
		old_value,
		new_value,
		0.2
	)
	
	var _start: bool = tween.start()
	
	yield(tween, "tween_all_completed")
	level_info.text = "Level: " + str(level) + " - Current Exp: " + str(new_value) + "/" + str(target_exp) 
