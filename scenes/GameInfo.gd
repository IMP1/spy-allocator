extends Scene

const GAME_DETAILS = preload("res://gui/GameDetails.tscn")
var SETUP = load("res://scenes/Setup.tscn") # A var to avoid cyclical dependencies

var games: Array = []

onready var _tabs: TabContainer = $TabContainer as TabContainer

func _ready() -> void:
	for game in games:
		print(game)
		var details = GAME_DETAILS.instance()
		_tabs.add_child(details)
		details.name = game.name
		details.setup(game)

func _back() -> void:
	var transition: int = Scene.Transition.FLY + Scene.Transition.UP + Scene.Transition.FADE
	var scene: Scene = SETUP.instance()
	_main_scene.change_scene(scene, transition, transition)
