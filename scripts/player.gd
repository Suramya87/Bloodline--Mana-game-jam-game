extends CharacterBody2D

const SPEED = 100.0
var interact = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var actionable_finder: Area2D = $ActionableFinder

	
func _physics_process(delta: float) -> void:
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
		# Idle animation
		if animated_sprite.animation == "walk_left":
			animated_sprite.play("idle_left")  # Idle facing left
		elif animated_sprite.animation == "walk_right":
			animated_sprite.play("idle_right")  # Idle facing right
		elif animated_sprite.animation == "walk_up":
			animated_sprite.play("idle_up")  # Idle facing up
		elif animated_sprite.animation == "walk_down":
			animated_sprite.play("idle_down")  # Idle facing down


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
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
		print("bitchin")
