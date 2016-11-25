
extends Node2D

# -1 is Left, 1 is Right
var direction = -1 setget ,direction_get

func direction_get():
	return direction

func _on_boundaryLeft_area_enter( area ):
	if(area.get_name().begins_with("enemy")):
		direction = -1


func _on_boundaryRight_area_enter( area ):
	if(area.get_name().begins_with("enemy")):
		direction = 1