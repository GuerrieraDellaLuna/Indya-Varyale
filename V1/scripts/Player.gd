class_name Player extends CharacterBody3D

signal input_dir_changed(new_dir: Vector3)

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 3.0
const MOUSE_SENSITIVITY = 0.0015

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health = 100

@onready var spring_arm: SpringArm3D = $CameraRoot/HorizontalRotation/VerticalRotation/SpringArm3D
@onready var model: MeshInstance3D = $MeshInstance3D
@onready var animation_player: AnimationPlayer = $MeshInstance3D/walk/AnimationPlayer
var health_bar: HealthBar

var input_dir: Vector3
var speed: float = 3
var acceleration: float = 5
const speed_still: float = 0
const speed_moving: float = 3


var nearby_collectable: Collectable = null

func _ready():
	health_bar = %Healthbar
	health_bar.init_health(health)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	input_dir_changed.emit(input_dir)

func _set_health(value):
	health = value
	health_bar.health = health

func _unhandled_input(event):
	if event.is_action_pressed("move") or event.is_action_released("move"):
		input_dir.z = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_dir.x = Input.get_action_strength("forward") - Input.get_action_strength("back")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if input_dir.x != 0 or input_dir.z != 0:
		speed = speed_moving
		input_dir_changed.emit(input_dir)
	else:
		speed = speed_still

	# Check if interact key is pressed
	if Input.is_action_just_pressed("interact"):
		print("Interact key pressed")
		if nearby_collectable:
			print("Collecting:", nearby_collectable)
			nearby_collectable.collect()

func set_nearby_collectable(collectable: Collectable):
	nearby_collectable = collectable
		
