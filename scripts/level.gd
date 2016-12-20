extends Node2D

var levelCompleted = false

func _ready():
	get_node("UI/GameOverLabel").hide()
	get_node("UI/YouWinLabel").hide()
	set_fixed_process(true)
	
func _fixed_process(delta):
	#update UI
	get_node("UI/ScoreValue").set_text(str(get_node("/root/game_state").score))
	get_node("UI/LivesValue").set_text(str(get_node("/root/game_state").lives))

func level_failed():
	levelCompleted = false
	get_node("UI/GameOverLabel").show()
	get_node("/root/game_state").game_over()
	get_node("GameEndDelay").start()
	get_node("BombingTimer").stop()
	#stop all enemies
	var enemies = get_tree().get_nodes_in_group("enemies")
	for e in enemies:
		e.set_fixed_process(false)
	
func check_if_level_completed():
	var enemies = get_tree().get_nodes_in_group("enemies")
	if(enemies.size() <= 1):
		levelCompleted = true
		get_node("UI/YouWinLabel").show()
		get_node("GameEndDelay").start()
	

func _on_Timer_timeout():
	var bombers = get_tree().get_nodes_in_group("bombers")
	if(bombers.size() > 0):
		var rand = floor(rand_range(0, bombers.size()))
		var bomb = preload("res://prefabs/bomb.tscn").instance()
		var pos = bombers[rand].get_node("shootFrom").get_global_pos()
		bomb.set_pos(pos)
		add_child(bomb)
	
func _on_GameEndDelay_timeout():
	if(levelCompleted):
		get_tree().change_scene("res://scenes/level.tscn")
	else:
		get_tree().change_scene("res://scenes/Menu.tscn")