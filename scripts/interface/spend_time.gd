extends Label
class_name TimeSpend

var elapsed_time: int = 0

func on_timer_timeout():
	elapsed_time += 1
	
	var seconds: int = elapsed_time % 60
	# warning-ignore:integer_division
	var minutes: int = (elapsed_time / 60) % 60
	
	text = "%02d:%02d" % [minutes, seconds]
