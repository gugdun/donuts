class_name Spawner

extends Node3D

@export var default_donuts: Array[PackedScene]
@export var force: float = 225.0
@export var angular_speed: float = 40.0
@export var angular_velocity: float = 7.5

func _spawn_donut(donut: Donut) -> void:
	var rand: Vector3 = Vector3(randf() * angular_speed * 2.0 - angular_speed, 0, 0)
	donut.angular_velocity = Vector3(randf() * angular_velocity, randf() * angular_velocity, randf() * angular_velocity)
	add_child(donut)
	donut.global_position = global_position
	donut.set_spawner(self)
	# donut.apply_force(Vector3.UP * force + rand) 
	# Donuts on the edges (spawners 0 and 8), fly off the edge of the screen, so I've removed the angle for now
	donut.apply_force(Vector3.UP * force)
	
func spawn_default_donut() -> void:
	var d: Donut = default_donuts.pick_random().instantiate()
	_spawn_donut(d)

func reset() -> void:
	for c in get_children():
		if c is Donut:
			c.queue_free()
