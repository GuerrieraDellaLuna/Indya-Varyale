extends RayCast3D

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(owner)
	pass # Replace with function body.

func _physics_process(delta):
	label.text = ""
	if is_colliding():
		var detect = get_collider()
		
		if detect is Collectable:
			label.text = detect.get_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
