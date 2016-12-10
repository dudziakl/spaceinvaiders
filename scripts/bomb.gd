extends Area2D

const SPEED = 300

var hit = false
var destroyed = false

func _ready():
	set_process(true)

func _process(delta):
	translate(Vector2(0, delta*SPEED))

func _on_visibility_exit_screen():
	queue_free()

func _on_bomb_area_enter( area ):
	if(area.get_name() == "ship"):
		#Hit the player
		area.hit_something()
		hit_something()

func hit_something():
	if (hit):
		return
	hit = true
	set_process(false)
	#Animate splash
	#get_node("anim").play("splash")
	queue_free()

func destroy():
	if (destroyed):
		return
	destroyed = true
	hit_something()