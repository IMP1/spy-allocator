extends Scene

const GAME_INFO = preload("res://scenes/GameInfo.tscn")
const ASSIGNMENT_SCENE = preload("res://scenes/PlayerAssignments.tscn")
const GAMES_PATH = "res://games"

var _possible_games: Array = []

onready var _count_input: SpinBox = $PlayerCount/Input as SpinBox
onready var _game_input: OptionButton = $GameInfo/Option as OptionButton
onready var _min_spy_input: SpinBox = $SpyCount/Min as SpinBox
onready var _max_spy_input: SpinBox = $SpyCount/Max as SpinBox
onready var _next_button: Button = $Button as Button

func _ready():
	_next_button.disabled = (_count_input.value == 0)
	var dir := Directory.new()
	dir.open(GAMES_PATH)
	dir.list_dir_begin(true, true)
	while true:
		var filename := dir.get_next()
		if filename == "":
			break
		var filepath := GAMES_PATH + "/" + filename
		var game: SpyGame = load(filepath) as SpyGame
		_possible_games.append(game)
		_game_input.add_item(game.name)
	dir.list_dir_end()
	_min_spy_input.max_value = _count_input.value
	_max_spy_input.max_value = _count_input.value

func _number_changed(new_num: float) -> void:
	_min_spy_input.max_value = new_num
	_max_spy_input.max_value = new_num

func _min_spy_changed(new_num: float) -> void:
	_max_spy_input.min_value = new_num

func _next_scene() -> void:
	var player_count: int = _count_input.value as int
	var spy_count_min: int = _min_spy_input.value as int
	var spy_count_max: int = _max_spy_input.value as int
	var game: SpyGame = _possible_games[_game_input.selected]
	var scene: Scene = ASSIGNMENT_SCENE.instance()
	scene.player_count = player_count
	scene.spy_count_min = spy_count_min
	scene.spy_count_max = spy_count_max
	scene.game = game
	_main_scene.change_scene(scene)

func _show_game_info() -> void:
	var transition = Scene.Transition.FLY + Scene.Transition.DOWN + Scene.Transition.FADE
	var scene: Scene = GAME_INFO.instance()
	scene.games = _possible_games
	_main_scene.change_scene(scene, transition, transition)
