extends HBoxContainer

@export var health_point: PackedScene
@export var max_health = 3

signal you_died

func _ready():
	setup_health_points(max_health)

func setup_health_points(max_hp: int):
	for i in range(max_hp):
		var healt_point = health_point.instantiate()
		add_child(healt_point)

func decrease_health():
	if self.get_child_count() > 0:
		remove_child(self.get_child(0))
		if self.get_child_count() < 1:
			you_died.emit()
