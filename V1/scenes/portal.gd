extends Area3D

@export var next_area: String = "res://"
@export var player_next_spawn_position = Vector3.ZERO
@export var player_facing_left: bool = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.player_next_spawn_position= player_next_spawn_position
		print("I have entered the area and changed scene")
		get_tree().change_scene_to_file(next_area)
		if player_facing_left:
			Global.player_facing_left=true
		else:
			Global.player_facing_left=false
		

func _on_body_exited(body):
	if body.is_in_group("player"):
		Global.player_next_spawn_position= player_next_spawn_position
		print("I have exited the area and changed scene")
		get_tree().change_scene_to_file(next_area)
		if player_facing_left:
			Global.player_facing_left=true
		else:
			Global.player_facing_left=false
