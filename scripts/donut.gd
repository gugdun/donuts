class_name Donut

extends RigidBody3D

@export var cut_mesh: CSGBox3D
@export var shape: CollisionShape3D

const slice_force: float = 50

var _sliceable: bool = true

func set_sliceable(val: bool) -> void:
	_sliceable = val
	shape.disabled = !val

func body_entered(body: Node) -> void:
	if body is Destroyer:
		queue_free()
	elif body is Trail and _sliceable:
		var trail: Trail = body as Trail
		trail.game.score.increment()
		_slice(trail)

func _slice(trail: Trail):
	# Cut self
	cut_mesh.global_position = trail.cut1.global_position
	cut_mesh.global_rotation = trail.cut1.global_rotation
	cut_mesh.visible = true
	call_deferred("set_sliceable", false)

	# Spawn second half
	var new_donut: Donut = duplicate()
	trail.game.add_child(new_donut)
	new_donut.global_position = global_position
	new_donut.cut_mesh.global_position = trail.cut2.global_position
	new_donut.cut_mesh.global_rotation = trail.cut2.global_rotation
	new_donut.cut_mesh.visible = true
	new_donut.call_deferred("set_sliceable", false)

	# Apply force to separate halfs
	apply_force(trail.get_dir() * slice_force)
	new_donut.apply_force(-trail.get_dir() * slice_force)
