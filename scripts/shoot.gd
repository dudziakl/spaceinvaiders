
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
	if (hit):
		return
	#Hit an enemy
	print("Hit: " + area.get_name())
	if (area.has_method("destroy")):
		area.destroy()
		_hit_something()

func _hit_something():
	if (hit):
		return
	hit = true
	set_process(false)
	#Animate splash
	get_node("AnimatedSprite/AnimationPlayer").play("laser_anim")
	#queue_free()
