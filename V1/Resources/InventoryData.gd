class_name InventoryData
extends Resource

@export var held_items: Array
@export var current_index: int = 0

static func create_new() -> InventoryData:
	var new_inventory = InventoryData.new();
	new_inventory.held_items = [ResourceLoader.load("res://Resources/Items/pendant.tres")];
	return new_inventory;
	
func add_item(item: Resource) -> void:
	held_items.append(item)
	var save_data = Save.save_data
	if save_data and save_data.book:
		print("added page to book")
		save_data.book.unlock_page_for_item(item)

