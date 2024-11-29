extends Node3D

@export var donut: PackedScene
@export var timer: Timer
@export var force: float = 225.0
@export var angular_speed: float = 40.0
@export var angular_velocity: float = 7.5

var _slicer: MeshSlicer

func _ready() -> void:
	_slicer = MeshSlicer.new()
	add_child(_slicer)
	timer.start()

func spawn() -> void:
	var inst: Donut = donut.instantiate()
	inst.set_slicer(_slicer)
	var rand: Vector3 = Vector3(randf() * angular_speed * 2.0 - angular_speed, 0, 0)
	inst.angular_velocity = Vector3(randf() * angular_velocity, randf() * angular_velocity, 0)
	add_child(inst)
	inst.apply_force(Vector3.UP * force + rand)
