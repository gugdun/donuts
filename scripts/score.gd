extends Node

@export var score: int = 0

signal score_incremented(amount: int)
signal score_reseted()


func increment(amount: int = 1):
	score += amount
	emit_signal("score_incremented", amount)


func reset():
	score = 0
	emit_signal("score_reseted", score)

func _on_ready() -> void:
	pass # Replace with function body.
