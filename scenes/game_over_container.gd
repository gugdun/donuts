extends PanelContainer

func _ready():
	self.visible = false

func _on_hp_container_you_died():
	GameState.set_state(GameState.State.GAME_OVER)
	self.visible = true

func _on_start_button_pressed():
	self.visible = false

func _on_reset_button_pressed():
	self.visible = false
