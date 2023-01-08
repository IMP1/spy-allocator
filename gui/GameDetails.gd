extends Control

var _game: SpyGame

onready var _link: Button = $Control/About/Link as Button
onready var _description: RichTextLabel = $Control/About/Description as RichTextLabel
onready var _secret_list: Container = $Control/Secrets/ScrollContainer/Box/List as Container

func setup(game: SpyGame) -> void:
	_game = game
	_link.text = game.link
	_description.text = game.description
	for secret in game.group_secrets:
		var label := Label.new()
		_secret_list.add_child(label)
		label.text = secret
		label.set("custom_fonts/font", _link.get("custom_fonts/font"))

func _open_link() -> void:
	OS.shell_open(_link.text)
