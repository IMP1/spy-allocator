extends Control

onready var _scene_container: Node = $CurrentScene as Node
onready var _current_scene: Scene = $CurrentScene.get_child(0) as Scene

const DEFAULT_TRANS = Scene.Transition.LEFT + Scene.Transition.FLY + Scene.Transition.FADE
const DEFAULT_DURATION = 0.2

func change_scene(next_scene: Scene, trans_in=DEFAULT_TRANS, trans_out=DEFAULT_TRANS, duration=DEFAULT_DURATION) -> void:
	_scene_container.add_child(next_scene)
	if _current_scene != null:
		_current_scene.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_current_scene.connect("transitioned_out", self, "_scene_finished", [_current_scene])
		_current_scene.transition_out(trans_out, duration)
	_current_scene = next_scene
	_current_scene.transition_in(trans_in, duration)

func _scene_finished(scene: Scene):
	scene.queue_free()
