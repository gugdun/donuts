extends Label

func _ready():
	text = "Best Score: " + str(BestScore.best_score)
	BestScore.connect("best_score_incremented", Callable(self, "update_label"))
	
func update_label(_amount: int):
	text = "Best Score: " + str(BestScore.best_score)
