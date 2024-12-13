class_name Game

extends Node3D

@export var max_points: int = 6
@export var pop_timeout: float = 1.0 / 75
@export var camera: Camera3D
@export var trails: Array[Trail]
@export var health_bar: HealthBar
@export var reset_button: ResetButton
@export var pause_button: Button
@onready var button_click_sound = $sound/button_click_sound
@onready var background_music = $sound/background_music

var pressed: Array[bool] = []
var points: Array[Array] = []
var timeout: Array[float] = []

func _ready() -> void:
	for i in trails.size():
		pressed.append(false)
		points.append([])
		timeout.append(0)
	get_tree().paused = true
	reset_button.add_reset_call(_on_reset)

func _process(delta: float) -> void:
	max_points = int(Engine.get_frames_per_second() / 12)
	pop_timeout = 2.0 / Engine.get_frames_per_second()
	for i in trails.size():
		timeout[i] += delta
		if timeout[i] >= pop_timeout and !points[i].is_empty():
			points[i].pop_front()
			timeout[i] = 0

func _physics_process(_delta: float) -> void:
	for i in trails.size():
		trails[i].update(points[i], pressed[i])

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() and event.index < trails.size():
			pressed[event.index] = true
			var projected: Vector3 = camera.project_position(event.position, 1)
			points[event.index].append(projected)
		elif event.is_released():
			pressed[event.index] = false
	elif event is InputEventScreenDrag and event.index < trails.size():
		if !pressed[event.index]:
			return
		var projected: Vector3 = camera.project_position(event.position, 1)
		points[event.index].append(projected)
		if points[event.index].size() > max_points:
			points[event.index].pop_front()

func _on_reset():
	button_click_sound.play()
	GameState.set_state(GameState.State.PLAYING)
	get_tree().paused = false
	pause_button.disabled = false

func _start_game() -> void:
	background_music.play()
	button_click_sound.play()
	$main_menu.visible = false
	$game_over_container.visible = false
	reset_button.do_reset()

func _pause_game() -> void:
	button_click_sound.play()
	if(GameState.current_state == GameState.State.PAUSED):
		GameState.set_state(GameState.State.PLAYING)
		get_tree().paused = false
	else:
		await button_click_sound.finished
		GameState.set_state(GameState.State.PAUSED)
		get_tree().paused = true
	
func _open_menu() -> void:
	background_music.stop()
	button_click_sound.play()
	GameState.set_state(GameState.State.IDLE)
	$main_menu.visible = true
	pause_button.disabled = false
	$game_over_container.visible = false

func game_over() -> void:
	GameState.set_state(GameState.State.GAME_OVER)
	get_tree().paused = true
	pause_button.disabled = true
	$game_over_container.visible = true
