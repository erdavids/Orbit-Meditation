extends Node2D

var state = "inhale"

func _ready():
	state = "rest"
	start_breathing()
	
func _process(delta):
	$Label.text = state

func start_breathing():
	if (state == "hold"):
		state = "exhale"
		$Node2D/Satellite.move($Node2D/Line.position)
		
	if (state == "rest"):
		state = "inhale"
		$Node2D/Satellite.move($Node2D/Line2.position)
	


func _on_Tween_tween_all_completed():
	if (state == "inhale"):
		state = "hold"
	elif (state == "exhale"):
		state = "rest"
		
	$Timer.set_wait_time(4)
	$Timer.start()


func _on_Timer_timeout():
	start_breathing()
