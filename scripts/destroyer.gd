class_name Destroyer

extends StaticBody3D

signal donut_destroyed

func area_entered(area: Area3D):
	var parent: Node = area.get_parent()
	if parent is Donut:
		var donut: Donut = parent
		if donut.is_sliceable():
			donut_destroyed.emit()
