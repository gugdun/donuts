extends Control

signal confirm
signal reject

func _ready():
	self.visible = false

func set_confirmation_info_label(confirmation_info):
	$confirmation_info_label.text = confirmation_info

func _confirm():
	confirm.emit()

func _reject():
	reject.emit()
