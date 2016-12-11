
extends Area2D

export var points = 0

var destroyed = false
var horizontalSpeed = 1
var verticalSpeed = 0.03
var direction = -1
var acceleration = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	acceleration += delta * 0.1
	direction = get_node("/root/Node2D/boundaries").direction_get()
	translate(Vector2(direction*horizontalSpeed*acceleration,verticalSpeed*acceleration))

func is_enemy():
	return not destroyed

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
	get_node("/root/game_state").score += points
	# call next invader to shoot
	if (is_in_group("bombers")): 
		if(get_parent().get_child_count() > 1):
			#print("Next enemy: " +get_parent().get_children()[1].get_name())
			get_parent().get_children()[1].add_to_group("bombers") = true
	queue_free()
	