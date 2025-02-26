extends Area2D

# Reference to the AnimatedSprite2D node
@export var animated_sprite: AnimatedSprite2D

# Frame indices for the door states
@export var closed_frame: int = 0
@export var open_frame: int = 1

# Whether the door is currently open
var is_open: bool = false

# Whether the player is in the interaction area
var player_in_area: bool = false

func _ready():
	# Connect the area's signals
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	# Check for player interaction
	if player_in_area and Input.is_action_just_pressed("ui_interact"):
		toggle_door()

func _on_body_entered(body):
	# Check if the entering body is the player
	if body.is_in_group("player"):  # Ensure your player node is in the "player" group
		player_in_area = true

func _on_body_exited(body):
	print('fuck')
	# Check if the exiting body is the player
	if body.is_in_group("player"):
		print('fuck')
		player_in_area = false

func toggle_door():
	# Toggle the door state
	is_open = !is_open

	# Change the frame of the AnimatedSprite2D
	if is_open:
		animated_sprite.frame = open_frame
		# Disable collision when the door is open
		$CollisionShape2D.disabled = true
	else:
		animated_sprite.frame = closed_frame
		# Enable collision when the door is closed
		$CollisionShape2D.disabled = false
