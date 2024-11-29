class_name Trail

extends StaticBody3D

@export var head_length: float = 0.02
@export var head_width: float = 0.01
@export var mesh_instance: MeshInstance3D
@export var transform_mesh: MeshInstance3D
@export var collider: CollisionShape3D

var _m: ImmediateMesh
var _pos: Vector3
var _dir: Vector3

func _ready() -> void:
	_m = mesh_instance.mesh as ImmediateMesh

func get_pos() -> Vector3:
	return _pos

func get_dir() -> Vector3:
	return _dir

func update(points: Array) -> void:
	_m.clear_surfaces()
	var size: int = points.size()
	if size < 2:
		collider.disabled = true
		return
	var delta: float = head_width / size
	var width: float = delta

	# Start coordinates
	var dir: Vector3 = points[0].direction_to(points[1]).normalized()
	var left: Vector3 = dir.rotated(Vector3(0, 0, 1), deg_to_rad(-90))
	var right: Vector3 = dir.rotated(Vector3(0, 0, 1), deg_to_rad(90))

	# Draw tail
	_m.surface_begin(Mesh.PRIMITIVE_LINES)
	_m.surface_add_vertex(points[0])
	_m.surface_add_vertex(points[1]+left*width)
	_m.surface_add_vertex(points[0])
	_m.surface_add_vertex(points[1]+right*width)
	_m.surface_end()

	# Draw body
	for i in range(2, size):
		var ndir: Vector3 = points[i-1].direction_to(points[i]).normalized()
		var nleft: Vector3 = ndir.rotated(Vector3(0, 0, 1), deg_to_rad(-90))
		var nright: Vector3 = ndir.rotated(Vector3(0, 0, 1), deg_to_rad(90))
		var nwidth: float = width + delta
		_m.surface_begin(Mesh.PRIMITIVE_LINES)
		_m.surface_add_vertex(points[i-1]+left*width)
		_m.surface_add_vertex(points[i]+nleft*nwidth)
		_m.surface_add_vertex(points[i-1]+right*width)
		_m.surface_add_vertex(points[i]+nright*nwidth)
		_m.surface_end()
		dir = ndir
		left = nleft
		right = nright
		width = nwidth

	# Draw head
	_m.surface_begin(Mesh.PRIMITIVE_LINES)
	_m.surface_add_vertex(points[size-1]+left*width)
	_m.surface_add_vertex(points[size-1]+dir*head_length)
	_m.surface_add_vertex(points[size-1]+right*width)
	_m.surface_add_vertex(points[size-1]+dir*head_length)
	_m.surface_end()

	# Move collider
	collider.position = points[size-1]
	collider.disabled = false
	transform_mesh.position = points[size-1]
	var target: Vector3 = transform_mesh.position+dir.rotated(Vector3(0,0,1),deg_to_rad(90))
	if abs(dir.y) > 0.01:
		transform_mesh.look_at(target)
	_pos = points[size-1]
	_dir = dir
