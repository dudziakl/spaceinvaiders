
extends Panel


func _on_NewGameButton_pressed():
	get_tree().change_scene("res://scenes/level.tscn")	

func _on_QuitButton_pressed():
	get_tree().quit()
