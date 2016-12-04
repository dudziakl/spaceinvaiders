extends Node2D


func _ready():
	pass


func _on_Timer_timeout():
	
	#var bombers = get_tree().get_nodes_in_group("enemies")
	#bombers.find(
	
	var bomb = preload("res://prefabs/bomb.tscn").instance()
	if(has_node("enemies/col9/enemyC9/shootFrom")):
		var pos = get_node("enemies/col9/enemyC9/shootFrom").get_global_pos()
		bomb.set_pos(pos)
		add_child(bomb)
	
