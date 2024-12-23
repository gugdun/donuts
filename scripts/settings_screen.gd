extends Control

@onready var optionButton = $OptionButton

var language_list = ["English", "Russian"]
var confirmation_text = 'Are you sure you wnat to reset your best score?'

signal reset_best_score
signal back_to_menu
signal change_language(language_label)

func _ready():
	for k in language_list:
		print(k)
		optionButton.add_item(k)

func _on_reset_score_button_pressed():
	$confirmation_modal.visible = true
	$confirmation_modal.set_confirmation_info_label(confirmation_text)

func _on_option_button_item_selected(index):
	change_language.emit(language_list[index])

func _on_back_to_menu_pressed():
	back_to_menu.emit()
	_close_confirmation_modal()

func _confirm_reset_best_score():
	reset_best_score.emit()
	_close_confirmation_modal()

func _close_confirmation_modal():
	$confirmation_modal.visible = false
