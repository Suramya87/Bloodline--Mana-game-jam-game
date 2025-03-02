extends Node


var dream_status: String = ""
var hole_status: String = ""
var dinner_talk: bool = true
var overlay_state: String = "fully_black"
var bg_state: bool = false

#func _physics_process(delta: float) -> void:
	#if dinner_talk:
		#print("SHOW")
	#if not dinner_talk:
		#print("NO")
