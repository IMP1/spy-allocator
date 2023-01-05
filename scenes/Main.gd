extends Control

onready var _scene_container: Node = $CurrentScene as Node
onready var _current_scene: Scene = $CurrentScene.get_child(0) as Scene

func change_scene(next_scene: Scene) -> void:
	_scene_container.add_child(next_scene)
	if _current_scene != null:
		_current_scene.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_current_scene.connect("transitioned_out", self, "_scene_finished", [_current_scene])
		_current_scene.transition_out()
	_current_scene = next_scene
	_current_scene.transition_in()

func _scene_finished(scene: Scene):
	scene.queue_free()
