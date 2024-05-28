class_name SaveData
extends Resource

@export var save_name: String

@export var inventory_enabled: bool = false;

@export var inventory: InventoryData
@export var book: BookData

func enable_inventory() -> void:
	self.inventory_enabled = true;
	return;

static func create_new(save_name: String) -> SaveData:
	var new_save: SaveData = SaveData.new();
	
	new_save.save_name = save_name;
	new_save.inventory_enabled = false;
	new_save.inventory = InventoryData.create_new();
	new_save.book = BookData.create_new();
	return new_save;

static func get_save_path(save_name: String) -> String:
	return "user://saves/" + save_name + ".tres";

func save() -> void:
	ResourceSaver.save(self, "user://saves/" + get_save_path(save_name) + ".tres", ResourceSaver.FLAG_NONE);

func load(levelName: String) -> SaveData:
	var path: String = get_save_path(levelName);
	
	return load(path) as SaveData;
