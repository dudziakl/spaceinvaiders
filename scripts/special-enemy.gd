
extends Area2D

export var points = 0

var destroyed = false
var verticalSpeed = -150
var pointsRange = [100, 200, 300]

func _ready():
	
	var rnd = randi() % pointsRange.size() #random from 0 to array.size()-1
	points = pointsRange[rnd]
	set_fixed_process(true)

func _fixed_process(delta):
	translate(Vector2(verticalSpeed*delta, 0))

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
	get_node("Sprite").hide()
	get_node("score").set_text(str(points))
	get_node("score").show()
	get_node("ScoreDisplayTimer").start()

func _on_visibility_exit_screen():
	queue_free()

func _on_ScoreDisplayTimer_timeout():
	queue_free()
