class_name Trail

extends StaticBody3D

@export var head_length: float = 0.02
@export var head_width: float = 0.01
@export var mesh_instance: MeshInstance3D
@export var collider: CollisionShape3D

@onready var _m: ImmediateMesh = mesh_instance.mesh as ImmediateMesh

var _dir: Vector3

func get_dir() -> Vector3:
	return _dir

func update(points: Array, pressed: bool) -> void:
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
	_m.surface_begin(Mesh.PRIMITIVE_TRIANGLES)

	_m.surface_set_normal(Vector3(0,0,-1))
	_m.surface_set_uv(Vector2(0.5,0))
	_m.surface_add_vertex(points[0])
	_m.surface_set_normal(Vector3(0,0,-1))
	_m.surface_set_uv(Vector2(0,1))
	_m.surface_add_vertex(points[1]+left*width)
	_m.surface_set_normal(Vector3(0,0,-1))
	_m.surface_set_uv(Vector2(1,1))
	_m.surface_add_vertex(points[1]+right*width)

	# Draw body
	for i in range(2, size):
		var ndir: Vector3 = points[i-1].direction_to(points[i]).normalized()
		var nleft: Vector3 = ndir.rotated(Vector3(0, 0, 1), deg_to_rad(-90))
		var nright: Vector3 = ndir.rotated(Vector3(0, 0, 1), deg_to_rad(90))
		var nwidth: float = width + delta
		
		_m.surface_set_normal(Vector3(0,0,-1))
		_m.surface_set_uv(Vector2(0,0))
		_m.surface_add_vertex(points[i-1]+left*width)
		_m.surface_set_normal(Vector3(0,0,-1))
		_m.surface_set_uv(Vector2(0,1))
		_m.surface_add_vertex(points[i]+nleft*nwidth)
		_m.surface_set_normal(Vector3(0,0,-1))
		_m.surface_set_uv(Vector2(1,0))
		_m.surface_add_vertex(points[i-1]+right*width)

		_m.surface_set_normal(Vector3(0,0,-1))
		_m.surface_set_uv(Vector2(1,0))
		_m.surface_add_vertex(points[i-1]+right*width)
		_m.surface_set_normal(Vector3(0,0,-1))
		_m.surface_set_uv(Vector2(0,1))
		_m.surface_add_vertex(points[i]+nleft*nwidth)
		_m.surface_set_normal(Vector3(0,0,-1))
		_m.surface_set_uv(Vector2(1,1))
		_m.surface_add_vertex(points[i]+nright*nwidth)
		
		dir = ndir
		left = nleft
		right = nright
		width = nwidth

	# Draw head
	_m.surface_set_normal(Vector3(0,0,-1))
	_m.surface_set_uv(Vector2(0,0))
	_m.surface_add_vertex(points[size-1]+left*width)
	_m.surface_set_normal(Vector3(0,0,-1))
	_m.surface_set_uv(Vector2(0.5,1))
	_m.surface_add_vertex(points[size-1]+dir*head_length)
	_m.surface_set_normal(Vector3(0,0,-1))
	_m.surface_set_uv(Vector2(1,0))
	_m.surface_add_vertex(points[size-1]+right*width)

	_m.surface_end()

	# Update collider
	collider.global_position = points[size-1]
	collider.disabled = !pressed
	_dir = dir
