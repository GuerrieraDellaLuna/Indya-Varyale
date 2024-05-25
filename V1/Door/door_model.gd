extends Node3D

var player_infront = false
var door_state = false

@onready var player_scene = preload("res://scenes/player.tscn")
@onready var spawn_pos_scene_path = $"SpawnPoint"

func _input(event):
	if Input.is_action_just_pressed("open_door"):
		if player_infront and not $AnimationPlayer.is_playing():
			door_state = !door_state
			if door_state:
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
		if not door_state:
			$AnimationPlayer.play("DoorClose")

func _on_portal_body_entered(body):
	if body.is_in_group("player"):
		var player_instance = body  # Assuming the player is already an instance
		player_instance.position = Vector3(-9.876,0,-71.484)
		
		get_tree().change_scene_to_file("res://scenes/locker_room.tscn")
		queue_free()
