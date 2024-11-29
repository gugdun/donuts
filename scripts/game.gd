extends Node3D

@export var max_points: int = 5
@export var pop_timeout: float = 0.1
@export var camera: Camera3D
@export var trail: Trail

var pressed: bool = false
var points: Array[Vector3] = []
var timeout: float = 0
var _points_changed: bool = false

func _process(delta: float) -> void:
	timeout += delta
	if timeout >= pop_timeout:
		var result = points.pop_front()
		if result != null:
			_points_changed = true
		timeout = 0
	trail.update(points)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			pressed = true
			var projected: Vector3 = camera.project_position(event.position, 1)
			points.append(projected)
			_points_changed = true
		elif event.is_released():
			pressed = false
	elif pressed and event is InputEventMouseMotion:
		var projected: Vector3 = camera.project_position(event.position, 1)
		points.append(projected)
		_points_changed = true
		if points.size() > max_points:
			var result = points.pop_front()
			if result != null:
				_points_changed = true
