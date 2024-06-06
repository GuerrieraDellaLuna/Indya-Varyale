class_name Collectable
extends StaticBody3D

@export var label_message: String = "Interact"
@export var label_action: String = "interact"
@export var item_resource: Resource

func _ready():
	$Area3D.connect("body_entered", Callable(self, "_on_Area3D_body_entered"))
	$Area3D.connect("body_exited", Callable(self, "_on_Area3D_body_exited"))
	# Load the resource programmatically for testing
	item_resource = ResourceLoader.load("res://Resources/Items/camera.tres")
	print("Collectable ready, item_resource:", item_resource)

func get_label():
	var key_name = ""
	for action in InputMap.action_get_events(label_action):
		if action is InputEventKey:
			key_name = OS.get_keycode_string(action.physical_keycode)
	return label_message + "\n[" + key_name + "]"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Handle the collection of the item
func collect() -> void:
	print("Collect function called")
	if item_resource:
		# Use the SaveManager singleton to access save_data
		var save_data = Save.save_data
		save_data.inventory.add_item(item_resource)
		
		print("Item added to inventory:", item_resource)
		queue_free() # Remove the collectible from the scene
		print("Collectible removed from scene")
	else:
		print("Fuck")
	
func _on_Area3D_body_entered(body):
	if body.is_in_group("player"):
		print("Player entered the area")
		body.set_nearby_collectable(self)

func _on_Area3D_body_exited(body):
	if body.is_in_group("player"):
		print("Player exited the area")
		body.set_nearby_collectable(null)
