extends Scene

const ASSIGNMENT_SCENE = preload("res://scenes/PlayerAssignments.tscn")
const GAMES_PATH = "res://games"

var _possible_games: Array = []

onready var _count_input: SpinBox = $PlayerCount/Input as SpinBox
onready var _game_input: OptionButton = $GameInfo/Option as OptionButton
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

func _number_changed(new_num: float) -> void:
	if new_num > 0:
		_next_button.disabled = false

func _next_scene() -> void:
	var player_count: int = _count_input.value as int
	var game: SpyGame = _possible_games[_game_input.selected]
	var scene: Scene = ASSIGNMENT_SCENE.instance()
	scene.player_count = player_count
	scene.game = game
	_main_scene.change_scene(scene)
