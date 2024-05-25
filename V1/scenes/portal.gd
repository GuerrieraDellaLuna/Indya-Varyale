extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
		if body.is_in_group("player"):
			var player_instance = body  # Assuming the player is already an instance
			player_instance.position = Vector3(-9.876,0,-71.484)
			
			get_tree().change_scene_to_file("res://scenes/level_v_3.tscn")
			queue_free()
