extends Scene

const PLAYER_ASSIGNMENT = preload("res://scenes/PlayerAssignment.tscn")
const FINISH_SCENE = preload("res://scenes/Finish.tscn")

var player_count: int = 1
var spy_count_min: int = 1
var spy_count_max: int = 1
var game: SpyGame

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var _assignments: TabContainer = $TabContainer as TabContainer
onready var _wipe: ScreenWipe = $Wipe as ScreenWipe

func _ready():
	_rng.randomize()
	var n := _rng.randi_range(0, game.group_secrets.size() - 1)
	var group_secret: String = game.group_secrets[n]
	var individual_secrets: Array = []
	if game.individual_secrets.has(group_secret):
		for secret in game.individual_secrets[group_secret]:
			individual_secrets.append(secret)
	individual_secrets.shuffle()
	for i in player_count:
		var assignment_scene = PLAYER_ASSIGNMENT.instance()
		_assignments.add_child(assignment_scene)
		assignment_scene.player_number = (i+1)
		var individual_secret = ""
		if individual_secrets.size() > 0:
			individual_secret = individual_secrets[i % individual_secrets.size()]
		var secrets: Dictionary = {"group_secret": group_secret, "ind_secret": individual_secret}
		assignment_scene.role = game.knowledge_format.format(secrets)
	var spy_count: int = _rng.randi_range(spy_count_min, spy_count_max)
	var spies = []
	while spies.size() < spy_count:
		var spy := _rng.randi_range(0, player_count - 1)
		if not spy in spies:
			spies.append(spy)
	for spy in spies:
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
