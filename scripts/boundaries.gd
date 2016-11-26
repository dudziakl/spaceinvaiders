
extends Node2D

# -1 is Left, 1 is Right
var direction = -1 setget ,direction_get

func direction_get():
	return direction

func _on_boundaryLeft_area_enter( area ):
	if(area.is_in_group("enemies")):
		#go right
		direction = 1


func _on_boundaryRight_area_enter( area ):
	if(area.is_in_group("enemies")):
		#go left
		direction = -1