extends ParallaxBackground
class_name Map

onready var floor_layer: ParallaxLayer = get_node("Floor")

export(int) var layer_speed

func _physics_process(delta) -> void:
	floor_layer.motion_offset.x -= delta * layer_speed
