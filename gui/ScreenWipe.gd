extends Panel
class_name ScreenWipe

signal wipe_finished()
signal wipe_midpoint()

export(float) var duration: float = 1.0

onready var _player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var _tween: Tween = $Tween as Tween

func play(wipe_name: String) -> void:
	var speed: float = 1.0 / duration
	_player.playback_speed = speed
	_player.play(wipe_name)
	yield(get_tree().create_timer(duration / 2), "timeout")
	emit_signal("wipe_midpoint")
	yield(_player, "animation_finished")
	emit_signal("wipe_finished")
