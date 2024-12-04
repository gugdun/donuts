extends Node

enum State {IDLE, PLAYING, PAUSED, GAME_OVER}


var current_state = State.IDLE


signal state_changed(old_state, new_state)

func set_state(new_state):
	if new_state != current_state:
		var old_state = current_state
		current_state = new_state
		emit_signal("state_changed", old_state, new_state)
		print("State changed from ", old_state, " to ", new_state)


func is_state(state):
	return current_state == state
