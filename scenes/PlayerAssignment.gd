extends Control

export(String) var title_format: String = "You are Player #{num}"
export(int) var player_number: int = 1  setget _set_player_number
export(String) var role: String = "" setget _set_role

var _revealing: bool = false

func _ready():
	$RolePanel/Role.visible = false
	$SealBroken.visible = false

func _set_role(new_role: String) -> void:
	role = new_role
	$RolePanel/Role.text = role

func _set_player_number(num: int) -> void:
	player_number = num
	$PlayerNumber.text = title_format.format({"num":player_number})

func reveal() -> void:
	_revealing = true
	$RolePanel/Role.visible = true
	$RolePanel/TextureRect.visible = false
	$SealBroken.visible = true

func hide() -> void:
	_revealing = false
	$RolePanel/Role.visible = false
	$RolePanel/TextureRect.visible = true
