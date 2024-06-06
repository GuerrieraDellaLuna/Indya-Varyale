extends CharacterBody3D

class_name Player

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 3.0
const MOUSE_SENSITIVITY = 0.0015

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health = 100

@onready var spring_arm = $SpringArm3D
@onready var model = $MeshInstance3D
@onready var animation_player = $MeshInstance3D/walk/AnimationPlayer
@onready var health_bar = $CanvasLayer/Healthbar

var nearby_collectable: Collectable = null

func _ready():
	health_bar.init_health(health)
	
func _set_health(value):
	health = value
	health_bar.health = health

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var turnStrenght = Input.get_axis("left", "right")
	var moveStrenght = Input.get_axis("forward", "back")
	
	rotate_y(-deg_to_rad(turnStrenght * ROTATION_SPEED))

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(0, 0, moveStrenght)).normalized()
	direction = direction.rotated(Vector3.UP, spring_arm.rotation.y)
	Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP,spring_arm.rotation.x)
	# (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		if !animation_player.is_playing():
			print("walking")
			animation_player.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if animation_player.is_playing():
			animation_player.stop()

	move_and_slide()
	
	# Check if interact key is pressed
	if Input.is_action_just_pressed("interact"):
		print("Interact key pressed")
		if nearby_collectable:
			print("Collecting:", nearby_collectable)
			nearby_collectable.collect()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# spring_arm.rotation.x -= event.relative.y * MOUSE_SENSITIVITY
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -90.0, 30.0)
		spring_arm.rotation.y -= event.relative.x * MOUSE_SENSITIVITY
		

func set_nearby_collectable(collectable: Collectable):
	nearby_collectable = collectable
		
