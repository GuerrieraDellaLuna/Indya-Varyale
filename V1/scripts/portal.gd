extends Area3D

@export var next_area: String = "res://"
@export var player_next_spawn_position = Vector3.ZERO
@export var player_facing_left: bool = false

func _on_body_entered(body):
	print("Portal on body entered")
	if body.is_in_group("player"):
		print("body is group player")
		var player = body as Player;
		player.scale = Vector3(4.5, 4.5, 4.5);
		player.speed = 5;
		Main.change_level(next_area, 1, player);
		

func _on_body_exited(body):
	print("portal on body exited")
#	if body.is_in_group("player"):
#		PortalDataSingleton.player_next_spawn_position= player_next_spawn_position
#		print("I have exited the area and changed scene")
#		get_tree().change_scene_to_file(next_area)
#		if player_facing_left:
#			PortalDataSingleton.player_facing_left=true
#		else:
#			PortalDataSingleton.player_facing_left=false
