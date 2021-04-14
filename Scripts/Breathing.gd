extends Node2D

var base_time = 4
var max_time = 10
var min_time = 1
var time_increment = 1

var inhale_time = 4
var exhale_time = 4
var rest_time = 4
var hold_time = 4

var state = "Customize"

var current_total = 0

var options = true

var current_orbits = 1
var rotating = false

var resetting = false

onready var orbits = [get_node("System/Orbit-1"), get_node("System/Orbit-2"), get_node("System/Orbit-3"), get_node("System/Orbit-4")]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Options/InhaleTime.text = str(base_time) + "s"
	$Options/ExhaleTime.text = str(base_time) + "s"
	$Options/HoldTime.text = str(base_time) + "s"
	$Options/RestTime.text = str(base_time) + "s"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (rotating):
		rotate_orbits()
	if (resetting):
		reset_orbits()
		
	$Instruction.text = state
	
	$Options/ExhaleTime.text = str(exhale_time) + "s"
	$Options/InhaleTime.text = str(inhale_time) + "s"
	$Options/RestTime.text = str(rest_time) + "s"
	$Options/HoldTime.text = str(hold_time) + "s"
		
func reset_orbits():
	$"System/Orbit-1".rotation_degrees = lerp($"System/Orbit-1".rotation_degrees, 0, .05)
	
func rotate_orbits():
	$"System/Orbit-1".rotation_degrees = (current_total - $"orbit-timer-1".time_left * 360) / current_total
	
func start_orbits():
	state = "Inhale"
	current_total = inhale_time
	$"orbit-timer-1".set_wait_time(current_total)
	$"orbit-timer-1".start()
	
func _on_orbittimer1_timeout():
	if ($"System/Orbit-1".visible):
		$"orbit-1".play()
	
	if (state == "Inhale"):
		state = "Hold"
		
		current_total = hold_time
		
	elif (state == "Hold"):
		state = "Exhale"
		
		current_total = exhale_time
	elif (state == "Exhale"):
		state = "Rest"
		
		current_total = rest_time
	elif (state == "Rest"):
		state = "Inhale"
		
		current_total = inhale_time
		
	$"orbit-timer-1".set_wait_time(current_total)
	$"orbit-timer-1".start()

func _on_PlanetButton_pressed():
	$Options.visible = !$Options.visible
	if ($Options.visible):
		rotating = false
		resetting = true
		state = "Customize"
		$"orbit-timer-1".stop()
		$Instruction.visible = false
	else:
		$"Options/Info".visible = false
		$"Instruction".visible = true
		start_orbits()
		rotating = true
		resetting = false


func _on_orbit1_finished():
	pass # Replace with function body.


func _on_BreathingButton_pressed():
	get_tree().change_scene("res://Breathing.tscn")


func _on_InhaleDecrease_pressed():
	if (inhale_time > min_time):
		inhale_time -= 1


func _on_InhaleIncrease_pressed():
	if (inhale_time < max_time):
		inhale_time += 1


func _on_ExhaleIncrease_pressed():
	if (exhale_time < max_time):
		exhale_time += 1


func _on_ExhaleDecrease_pressed():
	if (exhale_time > min_time):
		exhale_time -= 1


func _on_HoldTimeIncrease_pressed():
	if (hold_time < max_time):
		hold_time += 1


func _on_HoldTimeDecrease_pressed():
	if (hold_time > min_time):
		hold_time -= 1


func _on_RestTimeIncrease_pressed():
	if (rest_time < max_time):
		rest_time += 1


func _on_RestTimeDecrease_pressed():
	if (rest_time > min_time):
		rest_time -= 1


func _on_MeditationButton_pressed():
	get_tree().change_scene("res://App.tscn")


func _on_InfoButton_pressed():
	$"Options/Info".visible = !$"Options/Info".visible
