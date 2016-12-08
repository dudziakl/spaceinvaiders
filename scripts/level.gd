extends Node2D

func _on_Timer_timeout():
	var bombers = get_tree().get_nodes_in_group("bombers")
	if(bombers.size() > 0):
		var rand = floor(rand_range(0, bombers.size()))
		var bomb = preload("res://prefabs/bomb.tscn").instance()
		var pos = bombers[rand].get_global_pos()
		bomb.set_pos(pos)
		add_child(bomb)
	
	
