extends Label

func _ready():
	#text = "Score: " + str(Score.score)
	text = tr("score_label") + " "  + str(Score.score)
	Score.connect("score_incremented", Callable(self, "update_label"))
	Score.connect("score_reseted", Callable(self, "update_label"))
	
func update_label(_amount: int):
	print("updated score")
	#text = "Score: " + str(Score.score)
	text = tr("score_label") + " "  + str(Score.score)
