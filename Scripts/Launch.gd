extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$"Decal/Orbit-1".rotation_degrees = rand_range(0, 360)
	$"Decal/Orbit-2".rotation_degrees = rand_range(0, 360)



func _process(delta):
	$"Decal/Orbit-1".rotation_degrees += 5 * delta
	$"Decal/Orbit-2".rotation_degrees += 10 * delta


func _on_TextureButton_pressed():
	get_tree().change_scene("res://App.tscn")


func breathing_button():
	get_tree().change_scene("res://Tapping-Game.tscn")
