extends ColorRect

#@onready var tween = get_tree().create_tween()

func change_color(new_color: Color):
	self.color = new_color
#
##func fade_to(target_color: Color, duration: float):
	##if tween:
		##tween.kill()  
	##tween = get_tree().create_tween()
	##tween.tween_property(self, "color", target_color, duration)

func set_transparency(alpha: float):
	var new_color = self.color
	new_color.a = alpha  
	self.color = new_color
