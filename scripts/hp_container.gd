extends HBoxContainer

@export var health_point: PackedScene
@export var max_health = 3

signal you_died

func setup_health_points():
	for c in get_children():
		c.queue_free()
	for i in range(max_health):
		var health_instance = health_point.instantiate()
		call_deferred("add_child", health_instance)

func decrease_health():
	if self.get_child_count() > 0:
		remove_child(self.get_child(0))
		if self.get_child_count() < 1:
			you_died.emit()
