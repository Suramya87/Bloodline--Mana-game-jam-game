extends CharacterBody2D

const SPEED = 100.0
var dream = false
var is_audio_playing = false 
var interact = false
var can_move = false  # Controls whether the player can move
var last_direction = Vector2.ZERO  # Stores the last movement direction

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $ActionableFinder
@onready var BG_player =  $AudioStreamPlayer

func _ready() -> void:
	var BG = preload("res://assets/Sounds/Bgm.mp3")
	BG_player.stream = BG
	#BG_player.loop = true
	OL_color.set_transparency(0.0)
	OL_color.change_color(Color(255, 0, 0))
	#OL_color.fade_to(Color(0, 0, 1, 0), 1.0)
	#disable_movement()
	animated_sprite.play("waking_up")
	var actionables = actionable_finder.get_overlapping_areas()
	if actionables.size() > 0:
		disable_movement()
		#print("processing")
		actionables[0].action()
		#dream = true
		return
	
		
func _physics_process(delta: float) -> void:
	OL_color.set_transparency(0.0)
	OL_color.change_color(Color(255, 0, 0))
	# If movement is disabled, stop the player
	if  not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# Reset velocity
	velocity = Vector2.ZERO

	# Get input direction
	var input_direction := Vector2(
		Input.get_axis("move_left", "move_right"),  # Horizontal (left/right)
		Input.get_axis("move_up", "move_down")      # Vertical (up/down)
	)

	# Normalize diagonal movement
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
		last_direction = input_direction  # Store last movement direction

	# Apply movement
	velocity = input_direction * SPEED

	# Handle animations
	update_animation(input_direction)

	# Move the player
	move_and_slide()

func update_animation(direction: Vector2) -> void:
	if direction.length() > 0:
		if abs(direction.x) > abs(direction.y):
			# Horizontal movement (left/right)
			if direction.x < 0:
				animated_sprite.play("walk_left")  # Play left animation
			else:
				animated_sprite.play("walk_right")  # Play right animation
		else:
			# Vertical movement (up/down)
			if direction.y < 0:
				animated_sprite.play("walk_up")  # Play up animation
			else:
				animated_sprite.play("walk_down")  # Play down animation
	else:
		# If movement is disabled, go to the idle state based on last direction
		set_idle_animation()

func _on_room_detector_area_entered(area: Area2D) -> void:
	# Check if the Area2D is part of the "Rooms" group
	if area.is_in_group("Rooms"):
		var collision_shape = area.get_node("CollisionShape2D")
		var size = collision_shape.shape.extents * 2
		
		var view_size = get_viewport_rect().size
		
		# Set up camera limits
		var cam = $Camera2D
		cam.limit_top = collision_shape.global_position.y - size.y / 2
		cam.limit_left = collision_shape.global_position.x - size.x / 2
		
		cam.limit_bottom = cam.limit_top + size.y
		cam.limit_right = cam.limit_left + size.x

func _unhandled_input(event):
	if dream:
		enable_movement()
	if Input.is_action_just_pressed("ui_accept"):
		dream = true
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			print("processing")
			disable_movement()
			actionables[0].action()
			return
		#enable_movement()
		#print("bitchin")
	#print("done")

# Functions to enable/disable player movement during dialog
func disable_movement():
	can_move = false
	velocity = Vector2.ZERO  # Ensure the player stops immediately
	set_idle_animation()  # Set the correct idle animation

func enable_movement():
	can_move = true

# Function to set the idle animation based on the last direction moved
func set_idle_animation():
	if last_direction.x < 0:
		animated_sprite.play("idle_left")  # Idle facing left
	elif last_direction.x > 0:
		animated_sprite.play("idle_right")  # Idle facing right
	elif last_direction.y < 0:
		animated_sprite.play("idle_up")  # Idle facing up
	elif last_direction.y > 0:
		animated_sprite.play("idle_down")  # Idle facing down
		
func _process(delta):
	if State.bg_state != is_audio_playing:
		is_audio_playing = State.bg_state  
		if State.bg_state:
			BG_player.play()
		else:
			BG_player.stop()
