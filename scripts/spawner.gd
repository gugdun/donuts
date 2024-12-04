extends Node3D

@export var donut: PackedScene
@export var timer: Timer
@export var force: float = 225.0
@export var angular_speed: float = 40.0
@export var angular_velocity: float = 7.5

func _ready() -> void:
	timer.start()
	
func spawn() -> void:
	if (GameState.current_state != GameState.State.PLAYING):
		return
	var inst: Donut = donut.instantiate()
	var rand: Vector3 = Vector3(randf() * angular_speed * 2.0 - angular_speed, 0, 0)
	inst.angular_velocity = Vector3(randf() * angular_velocity, randf() * angular_velocity, randf() * angular_velocity)
	add_child(inst)
	inst.apply_force(Vector3.UP * force + rand)

func _on_hp_container_you_died():
	timer.stop() 
