extends StaticBody3D

# Path to the player scene file
const player_path: String = "res://scenes/player.tscn"

@onready var player_holder: Node3D = $PlayerHolder
var spawn_points: Array[Node3D] = []
var player: Player

func _ready():
	player_holder.add_child(player);
	
	for child in $SpawnPointHolder.get_children():
		if child is Node3D:
			spawn_points.append(child)
	print("Loaded " + str(spawn_points.size()) + " Spawn Points")

func spawn_player_in(spawn_point_idx: int) -> void:
	if spawn_points.size() == 0:
		printerr("Tried to spawn player in a level with no spawn points.")
		return
	
	if spawn_point_idx >= spawn_points.size():
		printerr("Tried to spawn in spawn point '" + str(spawn_point_idx) + "' but only " + str(spawn_points.size()) + " exist.")
		spawn_point_idx = 0
	
	player.global_position = spawn_points[spawn_point_idx].global_position;
	print("Spawned player in locker room")
	
	if PortalDataSingleton.player_facing_left:
		player.rotation_degrees.y = 180
	else:
		player.rotation_degrees.y = 0
		
	player.add_to_group("player")

func get_player() -> Player:
	return player

func set_player(new_player: Player):
	player = new_player
