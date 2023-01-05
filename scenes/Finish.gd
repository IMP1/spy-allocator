extends Scene

const GITHUB_URL = "https://github.com/IMP1/spy-allocator"

func _open_github() -> void:
	OS.shell_open(GITHUB_URL)

func _reset() -> void:
	var scene: Scene = load("res://scenes/Setup.tscn").instance()
	_main_scene.change_scene(scene)
