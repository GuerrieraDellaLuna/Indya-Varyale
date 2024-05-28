extends Node

signal sceneChanged(pos: Vector3)

# Exported variable for the initial relative position of the player
@export var initialRelativePlayerPos : Vector3 = Vector3.ZERO

var relativePlayerPos := Vector3.ZERO
var currentTriggers := []
var trigID := 0
var sceneSwitch := false

func changeScene(path: String, player: CharacterBody3D, trigger: Node3D):
	relativePlayerPos = player.global_transform.origin - trigger.global_transform.origin
	if trigger.has_method("getID"):
		trigID = trigger.getID()
	currentTriggers.clear()
	print("I am here in change Scene")
	sceneSwitch = true
	get_tree().change_scene_to_file(path)
	
func sceneSetup():
	for node in currentTriggers:
		if node.has_method("getID") && node.getID() == trigID:
			relativePlayerPos = initialRelativePlayerPos
			emit_signal("sceneChanged", relativePlayerPos)
			sceneSwitch = false
			return 
