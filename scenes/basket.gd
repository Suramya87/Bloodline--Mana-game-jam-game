extends Area2D
#
##var DialogManager = "res://singletons/DialogManager.gd"
#
#
## Dialog lines for this object
#@export var dialog_lines: Array[String] = [
	#"I will do it Tomorrow",
	#"why",]
	#
#
#
## Called when the node enters the scene tree
#func _ready():
	## Connect signals for body entered/exited
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
#
## Called when a body enters the area
#func _on_body_entered(body: Node2D):
	#if body.is_in_group("player"):
		##if event.is_action_pressed("interact"):
			## Start the dialog when the interact key is pressed
		#DialogManager.start_dialog(global_position, dialog_lines)
		## Enable interaction when the player is in range
		#set_process_unhandled_input(true)
#
## Called when a body exits the area
#func _on_body_exited(body: Node2D):
	#if body.is_in_group("player"):
		## Disable interaction when the player leaves the area
		#set_process_unhandled_input(false)
#
## Handle input events
##func _unhandled_input(event):
	##if body.is_in_group("player"):
		##if event.is_action_pressed("interact"):
			## Start the dialog when the interact key is pressed
			##DialogManager.start_dialog(global_position, dialog_lines)
			##print('fuck')
