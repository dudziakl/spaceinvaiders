
extends Area2D

var destroyed = false
var speed = 50
var direction = -1

func _ready():
	set_process(true)

func _process(delta):
	direction = get_node("/root/Node2D/boundaries").direction_get()
	translate(Vector2(direction*delta*speed,0))


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

