extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if SceneSwitcher.sceneSwitch == true : 
		for node in get_children():
			SceneSwitcher.currentTriggers.append(node)
		SceneSwitcher.sceneSetup()
