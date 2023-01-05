extends Control
class_name Scene

signal transitioned_in()
signal transitioned_out()

var transition_duration: float = 0.5

onready var _main_scene = get_node("/root/Main")

func transition_out() -> void:
	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0.0), transition_duration)
	tween.tween_property(self, "rect_position", Vector2(-360, 0), transition_duration)
	tween.play()

func transition_in() -> void:
	rect_position.x = 360
	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "rect_position", Vector2(0, 0), transition_duration)
	tween.play()
