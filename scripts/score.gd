extends Label

class_name Score

@export var score: int = 0

func _ready() -> void:
	update_score_label()

func increment(amount: int = 1):
	score += amount
	update_score_label()

func reset():
	score = 0
	update_score_label()

func update_score_label() -> void:
	text = "Score: " + str(score)
