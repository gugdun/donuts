extends HBoxContainer

@onready var healthPoint = preload("res://scenes/health_point.tscn")
@export var maxHealt = 3

signal you_died

func _ready():
	setup_health_points(maxHealt)
	SignalManager.donut_lost.connect(decrease_health)

func setup_health_points(max_hp: int):
	for i in range(max_hp):
		var healtPoint = healthPoint.instantiate()
		add_child(healtPoint)

func decrease_health():
	if self.get_child_count() > 0:
		remove_child(self.get_child(0))
		if self.get_child_count() < 1:
			you_died.emit()
