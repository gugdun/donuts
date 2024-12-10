class_name SpawnerAction

enum SpawnerActionType {SPAWN, DELAY, DESTROY}

# Объявление переменных
var type: SpawnerActionType
var index: int
var donut: Donut
var delay: float
var speed: float
var angle: float

# Основной конструктор
func _init(
	_type: SpawnerActionType = SpawnerActionType.SPAWN,
	_index: int = 0,
	_donut: Donut = null,
	_delay: float = 0.0,
	_speed: float = 0.0,
	_angle: float = 0.0
) -> void:
	type = _type
	index = _index
	donut = _donut
	delay = _delay
	speed = _speed
	angle = _angle

static func for_spawner(spawner_index: int) -> SpawnerAction:
	return SpawnerAction.new(SpawnerActionType.SPAWN, spawner_index, null, 0.0, 0.0, 0.0)
# Именованный конструктор для первого спавнера


# Именованный конструктор для DELAY с 0.5 секунд
static func for_delay(delay_time: float) -> SpawnerAction:
	return SpawnerAction.new(SpawnerActionType.DELAY, 0, null, delay_time, 0.0, 0.0)
