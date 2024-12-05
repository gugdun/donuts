extends Node

var best_score: int = 0
var config = ConfigFile.new()
var cfg_path = "user://best_score.cfg"
var section = "section"
var key = "best_score"

signal best_score_incremented(amount: int)

func _ready() -> void:
	load_best_score()

	# Найдем объект Score в дереве и подключим сигнал
	var score_object = get_node("/root/Score")  # Убедитесь, что путь верный
	score_object.connect("score_incremented", Callable(self, "_on_score_incremented"))

func _on_score_incremented(amount: int) -> void:
	# Логика обновления best_score
	if Score.score > best_score:
		best_score = Score.score
		save_best_score()
		best_score_incremented.emit(amount)
	#update_score_label()

func load_best_score() -> int:
	var err = config.load(cfg_path)
	
	if err != OK:
		return _file_not_found_or_currupted()
	
	if not config.has_section(section) or not config.has_section_key(section, key):
		return _section_or_key_missing()
	
	best_score = int(config.get_value(section, key, 0))  # Значение по умолчанию — 0
	print("Best score loaded: ", best_score)
	return 0

func save_best_score() -> void:
	config.set_value(section, key, best_score)
	config.save(cfg_path)

#func update_score_label() -> void:
	#$"../score_label".text = "Best score: " + str(best_score)

func _file_not_found_or_currupted() -> int:
	print("Config file not found or corrupted. Initializing default best_score...")
	best_score = -1
	save_best_score()
	return best_score

func _section_or_key_missing() -> int:
	print("Section or key missing. Initializing default best_score...")
	best_score = -2
	save_best_score()  # Создаем недостающие данные
	return best_score
