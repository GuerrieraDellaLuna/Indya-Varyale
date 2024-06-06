extends Control


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level_v_3.tscn")
	queue_free()


func _on_quit_pressed():
	get_tree().quit()
