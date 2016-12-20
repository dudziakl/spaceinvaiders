
extends Node2D

# -1 is Left, 1 is Right
var horizontalDirection = -1 setget ,horizontal_direction_get

func horizontal_direction_get():
	return horizontalDirection

func _on_boundaryLeft_area_enter( area ):
	if(area.is_in_group("enemies")):
		#go right
		horizontalDirection = 1

func _on_boundaryRight_area_enter( area ):
	if(area.is_in_group("enemies")):
		#go left
		horizontalDirection = -1