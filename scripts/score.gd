extends Node

@export var score: int = 0

signal score_incremented(amount: int)
signal score_reseted()

func increment(amount: int = 1):
	score += amount
	score_incremented.emit(amount)

func reset():
	score = 0
	score_reseted.emit(score)
