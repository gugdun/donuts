class_name Scheduler

extends Node3D

@export var spawners: Array[Spawner]
@export var timer: Timer


var actions: Array[SpawnerAction] = []

func _ready() -> void:
	
	ScheduleSingleton.scheduler = self
	GameState.state_changed.connect(_on_state_changed)
	

func _process(delta: float) -> void:

	if actions.size() <= 0:
		actions = _generateRandomActions()
	
	var current_action: SpawnerAction = actions[0]
	
	match current_action.type:
		SpawnerAction.SpawnerActionType.SPAWN:
			spawn_donut_at(current_action.index)
			actions.pop_front() # Переходим к следующему действию
		
		SpawnerAction.SpawnerActionType.DELAY:
			current_action.delay -= delta
			if current_action.delay <= 0:
				actions.pop_front()


func _generateRandomActions() -> Array[SpawnerAction]:
	var generated_actions: Array[SpawnerAction] = []
	var delay_time = 0.8

	for i in range(spawners.size()):
		generated_actions.append(SpawnerAction.for_spawner(i))
		generated_actions.append(SpawnerAction.for_delay(delay_time))

	generated_actions.shuffle()

	return generated_actions
		
func _on_state_changed(_old_state, new_state) -> void:
	if new_state == GameState.State.PLAYING:
		timer.start()
	elif new_state == GameState.State.GAME_OVER:
		timer.stop()


func reset() -> void:
	for s in spawners:
		s.reset()

func spawn_donut_at(index: int) -> void:
	print("spawn at index", index)
	if index < 0 or index >= spawners.size():
		push_error("Error: the index goes beyond the array of spawners.")
		return
	var spawner: Spawner = spawners[index]
	spawner.spawn_default_donut()
