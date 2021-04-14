extends Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(target):
	$Tween.interpolate_property(self, "position", position, target, 4, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
