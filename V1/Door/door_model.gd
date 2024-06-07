extends Node3D

var player_infront = false
var door_state = false
@export var teleport_scene: String
	
func _input(event):
	if Input.is_action_just_pressed("open_door"):
		var player = Main.get_player();
		player.scale = Vector3(4.5, 4.5, 4.5);
		player.speed = 5;
		Main.change_level(teleport_scene, 1, player);

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		player_infront = true
		$Label.show()

func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		player_infront = false
		$Label.hide()
		$AnimationPlayer.play("DoorClose")

