extends CharacterBody3D

#TODO: UNCOMMENT GRAVITY AND DEAL WITH COLLISIONS WHEN FLOOR AND WALLS PROPERLY IMPLEMENTED

var speed = 1.0
var direction = Vector3()

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 0

func _ready():
	randomize_direction()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle movement.
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	if is_on_wall():
		randomize_direction()
	move_and_slide()


func randomize_direction():
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
