extends Node


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Walk":
		get_tree().change_scene_to_file("res://scenes/Game.tscn")
