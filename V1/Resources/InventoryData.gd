class_name InventoryData
extends Resource

@export var held_items: Array
@export var current_index: int = 0

static func create_new() -> InventoryData:
	var new_inventory = preload("res://Resources/InventoryData.gd");
	new_inventory.held_items = [preload("res://Resources/Items/pendant.tres")];
	return new_inventory;
