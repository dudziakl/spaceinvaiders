extends ParallaxLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	
func _process(delta):
	var curPos = get_pos()
	curPos.x = curPos.x - 25 * delta
	set_pos(curPos)
