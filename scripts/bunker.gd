
extends Area2D

var strength = 3
var destroyed = false

func destroy():
	if (destroyed):
		return
	
	strength -= 1
	if(strength < 0):
		destroyed = true
		queue_free()
	
	#change picture 