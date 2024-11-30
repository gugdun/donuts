extends Button

@export var score: Score

func _ready() -> void:
	if score == null:
		score = get_node("../score")
	
	
func _on_pressed() -> void:
	if score != null:
		score.reset()
		print("Score has been reset!")
