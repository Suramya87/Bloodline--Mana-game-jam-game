extends AnimatedSprite2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"."


func _process(delta):
	if State.hole_status == "ready":  # Change "ui_right" to your input
		print("ready")
		animated_sprite_2d.frame = 1 
		
	if State.hole_status == "open":  # Change "ui_right" to your input
		print("open")
		animated_sprite_2d.frame = 2
		
	if State.hole_status == "dead":
		print("dead")
		animated_sprite_2d.frame = 3
	State.hole_status == "open"
	print("hole_status changed to:", State.hole_status)  # Debugging output
