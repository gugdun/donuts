class_name ResetButton

extends Button

@export var nodes_to_reset: Array[Node]

@onready var _reset_calls: Array[Callable] = []

func do_reset(custom_reset_calls: Array[Callable] = []) -> void:
	# Default reset logic
	Score.reset()
	for n in nodes_to_reset:
		n.reset()

	# Call user defined reset logic
	if custom_reset_calls.is_empty():
		for c in _reset_calls:
			c.call()
	else:
		for c in custom_reset_calls:
			c.call()

func add_reset_call(callable: Callable):
	_reset_calls.append(callable)

func remove_reset_call(callable: Callable):
	_reset_calls.erase(callable)
