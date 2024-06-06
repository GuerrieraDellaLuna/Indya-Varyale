extends Node3D

@export var player: Player
@export var mesh: MeshInstance3D
@export var rotation_speed: float = 4
var input_dir: Vector3
var direction: Vector3
var velocity: Vector3
var camera_rotation: float
var player_init_rotation: float
var mesh_init_rotation: float

func _ready():
	player_init_rotation = player.rotation.y 
	mesh_init_rotation = mesh.rotation.y

func _on_input_dir_change(new_input_dir: Vector3):
	direction = new_input_dir.rotated(Vector3.UP, camera_rotation + mesh_init_rotation + player_init_rotation)
	
func _on_camera_h_rotation_changed(new_camera_rotation):
	camera_rotation = new_camera_rotation

func _physics_process(delta):
	velocity.x = player.speed * direction.normalized().x;
	velocity.z = player.speed * direction.normalized().z;
	
	player.velocity = player.velocity.lerp(velocity, player.acceleration * delta);
	
	player.move_and_slide();
	
	if velocity.x != 0 or velocity.z != 0:
		if !player.animation_player.is_playing():
				player.animation_player.play("Walk")
	else:	
		if player.animation_player.is_playing():
			player.animation_player.stop()
	
	var target_rotation = atan2(-direction.z, direction.x) - player_init_rotation;
	mesh.rotation.y = lerp_angle(mesh.rotation.y, target_rotation, rotation_speed * delta);



