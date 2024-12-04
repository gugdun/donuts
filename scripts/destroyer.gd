class_name Destroyer

extends StaticBody3D

signal donut_destroyed

func area_entered(area: Area3D):
    if area.get_parent() is Donut:
        donut_destroyed.emit()
