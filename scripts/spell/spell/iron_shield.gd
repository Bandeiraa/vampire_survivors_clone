extends SpellTemplate
class_name IronShield

onready var lifetime: Timer = get_node("Lifetime")

var able_to_kill: bool = false

func _ready() -> void:
	lifetime.start()
	
	
func on_lifetime_timer_timeout() -> void:
	direction = -direction
	if able_to_kill:
		lifetime.start()
		queue_free()
		
	able_to_kill = true
