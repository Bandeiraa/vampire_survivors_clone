extends Collectable
class_name HealthPotion

var health: int

export(int) var min_health
export(int) var max_health

func _ready() -> void:
	randomize()
	health = int(round(rand_range(min_health, max_health)))
	
	
func send_object() -> void:
	global_info.character.update_health("increase", health)
	queue_free()
