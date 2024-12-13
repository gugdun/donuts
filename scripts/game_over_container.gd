extends Control

signal restart
signal menu

func _on_restart() -> void:
	restart.emit()

func _on_menu() -> void:
	menu.emit()
