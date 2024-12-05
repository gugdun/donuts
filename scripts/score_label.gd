extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Score: " + str(Score.score)
	Score.connect("score_incremented", Callable(self, "update_label"))
	Score.connect("score_reseted", Callable(self, "update_label"))
	
func update_label(amount: int):
	print("updated score")
	text = "Score: " + str(Score.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
