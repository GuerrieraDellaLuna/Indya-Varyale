extends Node

signal camera_h_rotation_changed(new_rotation: float)

@onready var camera_h_node = $HorizontalRotation
@onready var camera_v_node = $HorizontalRotation/VerticalRotation
@onready var spring_arm = $HorizontalRotation/VerticalRotation/SpringArm3D

@export var camera_max_v: float = 75
@export var camera_min_v: float = -55
@export var h_sensitivity: float = 0.1
@export var v_sensitivity: float = 0.1
@export var h_acceleration: float = 25
@export var v_acceleration: float = 25
@export var player: Player

var h_rot: float = 0;
var v_rot: float = 0;

# courtesy of https://www.youtube.com/watch?v=C-1AerTEjFU

# Called when the node enters the scene tree for the first time.
func _ready():
	spring_arm.add_excluded_object(player.get_rid())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	v_rot = clamp(v_rot, camera_min_v, camera_max_v)	
	
	camera_h_node.rotation_degrees.y = lerp(camera_h_node.rotation_degrees.y, h_rot, h_acceleration*delta)
	camera_v_node.rotation_degrees.x = lerp(camera_v_node.rotation_degrees.x, v_rot, v_acceleration*delta)
	
	camera_h_rotation_changed.emit(camera_h_node.rotation.y);

func _unhandled_input(event)-> void:
	if event is InputEventMouseMotion:
		h_rot -= event.relative.x * h_sensitivity
		v_rot -= event.relative.y * v_sensitivity
