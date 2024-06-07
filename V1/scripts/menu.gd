class_name MainMenu extends Control

signal start_level(path: String);

func _on_start_pressed():
	start_level.emit("res://scenes/level_v_3.tscn")

func _on_quit_pressed():
	get_tree().quit()
