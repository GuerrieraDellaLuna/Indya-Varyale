class_name Collectable
extends StaticBody3D

@export var label_message: String = "Interact"
@export var label_action: String = "interact"

func get_label():
	var key_name = ""
	for action in InputMap.action_get_events(label_action):
		if action is InputEventKey:
			key_name = OS.get_keycode_string(action.physical_keycode)
	return label_message + "\n[" + key_name + "]"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
