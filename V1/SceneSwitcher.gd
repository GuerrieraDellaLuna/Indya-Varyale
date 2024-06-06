extends Node

# Exported variable for the initial relative position of the player
@export var path : String = "res://"



func _on_child_entered_tree(node):
	get_tree().change_scene_to_file(path)
