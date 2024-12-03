extends HBoxContainer

@onready var healthPoint = preload("res://scenes/health_point.tscn")
@export var maxHealt = 3

signal you_died

func _ready():
	setUpHealthPoints(maxHealt)
	SignalManager.donutLost.connect(decreaseHealth)

func setUpHealthPoints(max: int):
	for i in range(max)	:
		var healtPoint = healthPoint.instantiate()
		add_child(healtPoint)

func decreaseHealth():
	if self.get_child_count() > 0:
		remove_child(self.get_child(0))
		if self.get_child_count() < 1:
			you_died.emit()
