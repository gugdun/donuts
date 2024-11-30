class_name Donut

extends RigidBody3D

@export var cut_material: Material
@export var mesh_instance: MeshInstance3D
@export var collider: CollisionShape3D

const slice_force: float = 50

var _slicer: MeshSlicer
var _sliceable: bool = true

func set_slicer(slicer: MeshSlicer) -> void:
	_slicer = slicer

func set_sliceable(val: bool) -> void:
	_sliceable = val

func disable_collider() -> void:
	collider.disabled = true

func body_entered(body: Node) -> void:
	if body is Destroyer:
		queue_free()
	elif body is Trail and _sliceable:
		var meshes: Array[ArrayMesh] = _slicer.slice_mesh(body.transform_mesh.transform, mesh_instance.mesh, cut_material)
		if meshes.size() > 0:
			var dir: Vector3 = body.get_dir().rotated(Vector3(0, 0, 1), deg_to_rad(90))
			set_sliceable(false)
			apply_force(dir * slice_force)
			call_deferred("disable_collider")
			mesh_instance.mesh = meshes[0]
			body.game.score.increment(1)
			if meshes.size() > 1:
				var new_donut = duplicate()
				new_donut.set_slicer(_slicer)
				new_donut.set_sliceable(false)
				new_donut.apply_force(-dir * slice_force)
				new_donut.mesh_instance.mesh = meshes[1]
				get_parent().add_child(new_donut)
				new_donut.call_deferred("disable_collider")
	
