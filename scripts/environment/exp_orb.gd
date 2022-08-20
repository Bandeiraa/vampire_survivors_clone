extends Collectable
class_name ExpOrb

var experience: int

func send_object() -> void:
	global_info.character.update_exp(experience)
	queue_free()
