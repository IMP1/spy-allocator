extends Scene

const PLAYER_ASSIGNMENT = preload("res://scenes/PlayerAssignment.tscn")
const FINISH_SCENE = preload("res://scenes/Finish.tscn")

var player_count: int = 1
var game: SpyGame

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var _assignments: TabContainer = $TabContainer as TabContainer
onready var _wipe: ScreenWipe = $Wipe as ScreenWipe

func _ready():
	_rng.randomize()
	var n := _rng.randi_range(0, game.possible_information.size() - 1)
	var secret: String = game.possible_information[n]
	for i in player_count:
		var assignment_scene = PLAYER_ASSIGNMENT.instance()
		_assignments.add_child(assignment_scene)
		assignment_scene.player_number = (i+1)
		assignment_scene.role = game.knowledge_format.format({"secret": secret})
	var spy := _rng.randi_range(0, player_count - 1)
	_assignments.get_child(spy).role = "You are the Spy"

func _next_player() -> void:
	if _assignments.current_tab == player_count - 1:
		var scene: Scene = FINISH_SCENE.instance()
		_main_scene.change_scene(scene)
	else:
		_play_wipe()

func _play_wipe() -> void:
	_wipe.visible = true
	_wipe.play("SwipeLeft")

func _wipe_midpoint() -> void:
	_assignments.current_tab += 1

func _wipe_finish() -> void:
	_wipe.visible = false
