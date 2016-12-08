extends Area2D

const SPEED = 300

var hit = false

func _ready():
	set_process(true)

func _process(delta):
	translate(Vector2(0, delta*SPEED))

func _on_visibility_exit_screen():
	queue_free()

func _on_bomb_area_enter( area ):
	#Hit the player
	pass

func _hit_something():
	if (hit):
		return
	hit = true
	set_process(false)
	#Animate splash
	#get_node("anim").play("splash")
	queue_free()
