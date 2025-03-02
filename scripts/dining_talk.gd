extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if State.dinner_talk:
		visible = true
	if not State.dinner_talk:
		visible = false
