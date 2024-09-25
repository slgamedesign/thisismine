extends Control



func _on_play_pressed():
	self.hide()
	get_tree().change_scene_to_file("res://Scenes/Testing.tscn")


func _on_quit_pressed():
	get_tree().quit()
