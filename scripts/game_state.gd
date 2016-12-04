
extends Node

var score = 0
var highscore = 0

func _ready():
	var f = File.new()
	# Load high score
	if (f.open("user://highscore", File.READ) == OK):
		highscore = f.get_var()

func game_over():
	if (score > highscore):
		highscore = score
		# Save high score
		var f = File.new()
		f.open("user://highscore", File.WRITE)
		f.store_var(highscore)

