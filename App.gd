extends Node2D

var base_time = 15
var max_time = 600
var min_time = 15
var time_increment = 15

var timer_one_in_seconds = 0
var timer_two_in_seconds = 0
var timer_three_in_seconds = 0
var timer_four_in_seconds = 0

var options = true

var current_orbits = 1
var max_orbits = 4

var rotating = false

var resetting = false

onready var orbits = [get_node("System/Orbit-1"), get_node("System/Orbit-2"), get_node("System/Orbit-3"), get_node("System/Orbit-4")]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Options/OrbitCount.text = str(current_orbits)
	$Options/OrbitPeriodTime.text = str(base_time) + "s"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (rotating):
		rotate_orbits()
	if (resetting):
		reset_orbits()
		
func reset_orbits():
	$"System/Orbit-1".rotation_degrees = lerp($"System/Orbit-1".rotation_degrees, 0, .05)
	$"System/Orbit-2".rotation_degrees = lerp($"System/Orbit-2".rotation_degrees, 0, .05)	
	$"System/Orbit-3".rotation_degrees = lerp($"System/Orbit-3".rotation_degrees, 0, .05)
	$"System/Orbit-4".rotation_degrees = lerp($"System/Orbit-4".rotation_degrees, 0, .05)
	
func rotate_orbits():
	$"System/Orbit-1".rotation_degrees = (timer_one_in_seconds - $"orbit-timer-1".time_left * 360) / timer_one_in_seconds
	$"System/Orbit-2".rotation_degrees = (timer_two_in_seconds - $"orbit-timer-2".time_left * 360) / timer_two_in_seconds
	$"System/Orbit-3".rotation_degrees = (timer_three_in_seconds - $"orbit-timer-3".time_left * 360) / timer_three_in_seconds
	$"System/Orbit-4".rotation_degrees = (timer_four_in_seconds - $"orbit-timer-4".time_left * 360) / timer_four_in_seconds
	
	
	
func start_orbits():
	timer_one_in_seconds = base_time
	timer_two_in_seconds = timer_one_in_seconds * 2
	timer_three_in_seconds = timer_two_in_seconds * 2
	timer_four_in_seconds = timer_three_in_seconds * 2
	
	$"orbit-timer-1".set_wait_time(timer_one_in_seconds)
	$"orbit-timer-1".start()
	
	$"orbit-timer-2".set_wait_time(timer_two_in_seconds)
	$"orbit-timer-2".start()
	
	$"orbit-timer-3".set_wait_time(timer_three_in_seconds)
	$"orbit-timer-3".start()
	
	$"orbit-timer-4".set_wait_time(timer_four_in_seconds)
	$"orbit-timer-4".start()


func final_timeout():
	rotating = false
	resetting = true
	$"orbit-timer-1".stop()
	$"orbit-timer-2".stop()
	$"orbit-timer-3".stop()
	$"orbit-timer-4".stop()
	
func _on_orbittimer1_timeout():
	if ($"System/Orbit-1".visible):
		$"orbit-1".play()
		if ($"System/Orbit-2".visible == false):
			final_timeout()


func _on_orbittimer2_timeout():
	if ($"System/Orbit-2".visible):
		$"orbit-2".play()
		if ($"System/Orbit-3".visible == false):
			final_timeout()


func _on_orbittimer3_timeout():
	if ($"System/Orbit-3".visible):
		$"orbit-3".play()
		if ($"System/Orbit-4".visible == false):
			final_timeout()


func _on_orbittimer4_timeout():
	if ($"System/Orbit-4".visible):
		$"orbit-4".play()
		final_timeout()

func _on_OrbitalPeriodDecrease_pressed():
	if (base_time > min_time):
		base_time -= time_increment
		
	$Options/OrbitPeriodTime.text = str(base_time) + "s"


func _on_OrbitalPeriodIncrease_pressed():
	if (base_time < max_time):
		base_time += time_increment
		
	$Options/OrbitPeriodTime.text = str(base_time) + "s"


func _on_OrbitsIncrease_pressed():
	if (current_orbits < max_orbits):
		current_orbits += 1
		var count = 1
		for o in orbits:
			o.visible = (count <= current_orbits)
			count += 1
			
	$Options/OrbitCount.text = str(current_orbits)


func _on_OrbitsDecrease_pressed():
	if (current_orbits > 1):
		current_orbits -= 1
		
		var count = 1
		for o in orbits:
			o.visible = (count <= current_orbits)
			count += 1
	$Options/OrbitCount.text = str(current_orbits)

func _on_PlanetButton_pressed():
	$Options.visible = !$Options.visible
	if ($Options.visible):
		final_timeout()
	else:
		$"Options/Info".visible = false
		start_orbits()
		rotating = true
		resetting = false

func _on_BreathingButton_pressed():
	get_tree().change_scene("res://Breathing.tscn")

func _on_InfoButton_pressed():
	$Options/Info.visible = !$Options/Info.visible
