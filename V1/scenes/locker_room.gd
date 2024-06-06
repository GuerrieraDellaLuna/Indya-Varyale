extends StaticBody3D

# Path to the player scene file
const player_path: String = "res://scenes/player.tscn"

func _ready():
	# Load the player scene and instantiate it
	var player_scene = preload(player_path)
	if player_scene:
		var player = player_scene.instantiate()
		
		# Set the player's position to the next spawn position from the Global script
		player.position = Global.player_next_spawn_position
		print("The player position in locker room: ", player.position)
		
		# Set the player's facing direction based on a global variable
		if Global.player_facing_left:
			player.rotation_degrees.y = 180  # Assuming the player sprite faces right by default
		else:
			player.rotation_degrees.y = 0
		# Add the player to the current node
		add_child(player)
		
		# Add the player to the "player" group for easy access from other scripts
		player.add_to_group("player")
	else:
		print("Error: Could not load player scene at path: ", player_path)
