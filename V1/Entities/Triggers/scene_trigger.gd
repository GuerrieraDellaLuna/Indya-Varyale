extends Node3D

@export var path: String = "res://"
@export var visibleTrigger: bool = false
@export var ID: int = 0

func _ready():
	if !visibleTrigger:
		for node in $Area.get_children():
			if node is MeshInstance3D:
				node.queue_free()
				
func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		SceneSwitcher.changeScene(path,body,self)
		self.queue_free()

func getID():
	return ID
	
func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		SceneSwitcher.changeScene(path,body,self)
		self.queue_free()
