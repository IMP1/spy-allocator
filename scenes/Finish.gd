extends Scene

const GITHUB_URL = "https://github.com/IMP1/spy-allocator"

func _open_github() -> void:
	OS.shell_open(GITHUB_URL)

func _reset() -> void:
	# TODO: Some other transition
	var transition: int = Scene.Transition.FLY + Scene.Transition.RIGHT + Scene.Transition.FADE
	var scene: Scene = load("res://scenes/Setup.tscn").instance()
	_main_scene.change_scene(scene, transition, transition)
