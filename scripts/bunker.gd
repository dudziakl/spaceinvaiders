
extends Area2D

var damageLevel = 0
var maxDamage = 4
var destroyed = false

func destroy():
	if (destroyed):
		return
	
	damageLevel += 1
	if(damageLevel > maxDamage):
		destroyed = true
		queue_free()
	
	#change picture 
	get_node("Sprite").set_frame(damageLevel)