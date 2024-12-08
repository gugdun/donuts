class_name HealthBar

extends HBoxContainer

@export var health_point: PackedScene
@export var max_health = 3
@onready var damage_sound = $damage_sound
@onready var game_over_sound = $game_over_sound

signal you_died

func reset():
	for c in get_health_points():
		c.queue_free()
	for i in range(max_health):
		var health_instance = health_point.instantiate()
		call_deferred("add_child", health_instance)
		health_instance.add_to_group("health_points")

func decrease_health():
	var health_points = get_health_points()
	if health_points.size() > 0:
		remove_child(health_points[0])
		damage_sound.play()
		await damage_sound.finished
		if get_health_points().size() < 1:
			you_died.emit()
			game_over_sound.play()

func get_health_points():
	return get_tree().get_nodes_in_group("health_points")
