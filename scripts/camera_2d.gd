extends Camera2D

# Get references to the ColorRects in the scene
@onready var blank_color_rect = $BlankColorRect
@onready var fully_black_color_rect = $FullyBlackColorRect
@onready var partially_black_color_rect = $PartiallyBlackColorRect

# Function to toggle visibility based on the global overlay_state
func _process(delta):
	match State.overlay_state:
		"blank":
			blank_color_rect.visible = true
			fully_black_color_rect.visible = false
			partially_black_color_rect.visible = false
		"fully_black":
			blank_color_rect.visible = false
			fully_black_color_rect.visible = true
			partially_black_color_rect.visible = false
		"partially_black":
			blank_color_rect.visible = false
			fully_black_color_rect.visible = false
			partially_black_color_rect.visible = true
		_:
			# If the state is something unexpected, hide all ColorRects
			blank_color_rect.visible = false
			fully_black_color_rect.visible = false
			partially_black_color_rect.visible = false
