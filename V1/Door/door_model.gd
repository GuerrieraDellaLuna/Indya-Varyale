extends Node3D


var player_infront = false

var door_state = false


func _input(event):
	
	if Input.is_action_just_pressed("open_door"):
		
		#if player_infront == true and $AnimationPlayer.is_playing() == false:*/
			
		door_state = !door_state
		if door_state == true:
			$AnimationPlayer.play("DoorOpen")
		else:
			$AnimationPlayer.play("DoorClose")


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		player_infront = true
		$Label.show()


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		player_infront = false
		$Label.hide()


func _on_portal_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/room_8.tscn")
		queue_free()
