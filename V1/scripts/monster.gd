extends CharacterBody3D
var animationPlayer : AnimationPlayer
var animationPlayer2 : AnimationPlayer
var speed = 0.7
var direction = Vector3()
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var chaseDistance = 30
var hitDistance = 10
@onready var player = $"../Player"


func _ready():
	animationPlayer = $AnimationPlayer
	animationPlayer2 = $AnimationPlayer2
	randomize_direction()

func _physics_process(delta):
	# Add the gravity.
	if animationPlayer.is_playing():
		pass
	else:
		animationPlayer.play("walk")
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle movement.
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Rotate the character to face the movement direction.
	if direction.length_squared() > 0.001:  # Only rotate if there's a significant direction change.
		var target_rotation = atan2(direction.x, direction.z)
		rotation.y = target_rotation

	if player:
		var playerPosition = player.global_transform.origin
		var distanceToPlayer = global_transform.origin.distance_to(playerPosition)
		if distanceToPlayer < hitDistance:
			animationPlayer.stop()
			animationPlayer2.play("atack")
			player.reduce_health(40)
		else:
			animationPlayer2.stop()
			animationPlayer.play("walk")
		# Check if player is within chase distance
		if distanceToPlayer < chaseDistance:
			# Set direction towards player
			direction = (playerPosition - global_transform.origin).normalized()
		else:
			# Randomly roam
			if is_on_wall():
				randomize_direction()

	move_and_slide()

func randomize_direction():
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
