
extends Area2D

const SPEED = 800

var hit = false


func _ready():
	set_process(true)

func _process(delta):
	translate(Vector2(0, -delta*SPEED))

func _on_visibility_exit_screen():
	queue_free()

func _on_shoot_area_enter( area ):
	#Hit an enemy
	if (area.has_method("destroy")):
		# Duck typing at it's best
		area.destroy()
		_hit_something()

func _hit_something():
	if (hit):
		return
	hit = true
	set_process(false)
	#Animate splash
	#get_node("anim").play("splash")
	queue_free()
