
extends Area2D

var destroyed=false

func destroy():
	if (destroyed):
		return
	destroyed = true
	#animate explode
	#get_node("anim").play("explode")	
	set_fixed_process(false)
	#play explosion sound
	#get_node("sfx").play("sound_explode")
	# add points to score
	#get_node("/root/game_state").points += 5
	queue_free()

