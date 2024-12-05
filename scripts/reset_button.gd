extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_pressed() -> void:
	Score.reset()
	remove_all_donuts()
	pass # Replace with function body.

	
func remove_all_donuts() -> void:
	var parent: Node = $"../../scene/spawner" 
	for child in parent.get_children():  
		if child is Donut:  
			child.queue_free()
