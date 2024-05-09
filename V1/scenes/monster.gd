extends CharacterBody3D

var speed = 1.0
var direction = Vector3()
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	randomize_direction()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle movement.
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Rotate the character to face the movement direction.
	if direction.length_squared() > 0.001:  # Only rotate if there's a significant direction change.
		var target_rotation = direction.angle_to(Vector3.FORWARD)  # Calculate angle to face direction.
		rotation.y = target_rotation  # Set the character's y rotation.

	if is_on_wall():
		randomize_direction()
	
	move_and_slide()

func randomize_direction():
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
