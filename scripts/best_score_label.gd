extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Best Score: " + str(BestScore.best_score)
	BestScore.connect("best_score_incremented", Callable(self, "update_label"))
	
func update_label(amount: int):
	text = "Best Score: " + str(BestScore.best_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
