class_name Destroyer

extends StaticBody3D

signal donut_destroyed

func body_entered(body: Node3D):
    if body is Donut:
        donut_destroyed.emit()
