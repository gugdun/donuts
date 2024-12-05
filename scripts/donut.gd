class_name Donut

extends RigidBody3D

@export var donut: Node3D
@export var left_half: Node3D
@export var right_half: Node3D

const slice_force: float = 50

var _sliceable: bool = true
var _spawner: Spawner

func is_sliceable() -> bool:
	return _sliceable

func set_spawner(spawner: Spawner) -> void:
	_spawner = spawner

func set_sliceable(val: bool) -> void:
	_sliceable = val

func body_entered(body: Node) -> void:
	if body is Destroyer:
		queue_free()
	elif body is Trail and _sliceable:
		var trail: Trail = body as Trail
		trail.game.score.increment()
		_slice(trail)

func _slice(trail: Trail):
	# Cut self
	donut.visible = false
	right_half.visible = false
	left_half.visible = true
	call_deferred("set_sliceable", false)

	# Spawn second half
	var new_donut: Donut = duplicate()
	_spawner.add_child(new_donut)
	new_donut.global_position = global_position
	new_donut.angular_velocity = -angular_velocity
	new_donut.donut.visible = false
	new_donut.left_half.visible = false
	new_donut.right_half.visible = true
	new_donut.call_deferred("set_sliceable", false)

	# Apply force to separate halfs
	apply_force(trail.get_dir() * slice_force)
	new_donut.apply_force(-trail.get_dir() * slice_force)
