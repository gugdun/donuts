class_name Scheduler

extends Node3D

enum Preset { SINGLE, DOUBLE, TRIPLE, QUAD }

@export var preset: Preset = Preset.SINGLE
@export var spawners: Array[Spawner]
@export var timer: Timer

func _ready() -> void:
	timer.start()
	GameState.state_changed.connect(_on_state_changed)

func _on_state_changed(_old_state, new_state) -> void:
	if new_state == GameState.State.GAME_OVER:
		timer.stop()

func on_timer_tick() -> void:
	match preset:
		Preset.SINGLE:
			if spawners.size() < 1:
				return
			var s: Spawner = spawners[0]
			s.spawn_default_donut()
		_:
			pass

func reset() -> void:
	if !timer.is_stopped():
		timer.stop()
	timer.start()
