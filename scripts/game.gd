class_name Game

extends Node3D

@export var max_points: int = 5
@export var pop_timeout: float = 1.0 / 60
@export var camera: Camera3D
@export var trail: Trail
@export var score: Score

var pressed: bool = false
var points: Array[Vector3] = []
var timeout: float = 0

func _process(delta: float) -> void:
	max_points = int(Engine.get_frames_per_second() / 12)
	pop_timeout = 2.0 / Engine.get_frames_per_second()
	timeout += delta
	if timeout >= pop_timeout and !points.is_empty():
		points.pop_front()
		timeout = 0
	trail.update(points, pressed)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			pressed = true
			var projected: Vector3 = camera.project_position(event.position, 1)
			points.append(projected)
		elif event.is_released():
			pressed = false
	elif pressed and event is InputEventMouseMotion:
		var projected: Vector3 = camera.project_position(event.position, 1)
		points.append(projected)
	if points.size() > max_points:
			points.pop_front()

func _start_game() -> void:
	print("Start GAME")
	GameState.set_state(GameState.State.PLAYING)
	$MainMenu.visible = false
	return

func _pause_game() -> void:
	if(GameState.current_state == 2):
		GameState.set_state(GameState.State.PLAYING)
		get_tree().paused = false
	else:
		GameState.set_state(GameState.State.PAUSED)
		get_tree().paused = true
	return
	
func _open_menu() -> void:
	GameState.set_state(GameState.State.IDLE)
	$MainMenu.visible = true
	score.reset()
	return
