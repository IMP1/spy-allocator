extends Control
class_name Scene

signal transitioned_in()
signal transitioned_out()

enum Transition { LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3, FLY = 4, FADE = 8 }

onready var _window_width: float = ProjectSettings.get_setting("display/window/size/width")
onready var _window_height: float = ProjectSettings.get_setting("display/window/size/height")

onready var _main_scene = get_node("/root/Main")

func transition_out(transition: int, duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	var trans_direction = transition & 0x3
	if transition & Transition.FADE:
		tween.tween_property(self, "modulate", Color(1, 1, 1, 0.0), duration)
	if transition & Transition.FLY:
		if trans_direction == Transition.LEFT:
			tween.tween_property(self, "rect_position", Vector2(-_window_width, 0), duration)
		elif trans_direction == Transition.RIGHT:
			tween.tween_property(self, "rect_position", Vector2(_window_width, 0), duration)
		elif trans_direction == Transition.UP:
			tween.tween_property(self, "rect_position", Vector2(0, -_window_height), duration)
		elif trans_direction == Transition.DOWN:
			tween.tween_property(self, "rect_position", Vector2(0, _window_height), duration)
	tween.play()

func transition_in(transition: int, duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	var trans_direction = transition & 0x3
	if transition & Transition.FADE:
		modulate.a = 0
		tween.tween_property(self, "modulate", Color(1, 1, 1, 1.0), duration)
	if transition & Transition.FLY:
		if trans_direction == Transition.LEFT:
			rect_position.x = _window_width
		elif trans_direction == Transition.RIGHT:
			rect_position.x = -_window_width
		elif trans_direction == Transition.UP:
			rect_position.y = _window_height
		elif trans_direction == Transition.DOWN:
			rect_position.y = -_window_height
		tween.tween_property(self, "rect_position", Vector2(0, 0), duration)
	tween.play()
