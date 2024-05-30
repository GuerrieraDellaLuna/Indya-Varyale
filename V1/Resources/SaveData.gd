class_name SaveData
extends Resource

@export var inventory_enabled: bool = false;
@export var save_name: String = "";
@export var inventory: InventoryData
@export var book: BookData 

func enable_inventory() -> void:
	self.inventory_enabled = true;
	return;

static func create_new() -> SaveData:
	var new_save = SaveData.new();
	new_save.inventory_enabled = false;
	new_save.inventory = InventoryData.create_new();
	new_save.book = BookData.create_new();
	return new_save;
