
extends Area2D

var destroyed = false
var horizontalSpeed = 1
var verticalSpeed = 0.05
var direction = -1
var acceleration = 1

func _ready():
	set_process(true)

func _process(delta):
	acceleration += delta * 0.1
	direction = get_node("/root/Node2D/boundaries").direction_get()
	translate(Vector2(direction*horizontalSpeed*acceleration,verticalSpeed*acceleration))


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

