extends Node

var save_data: SaveData = SaveData.create_new()

const save_directory: String = "user://saves/"
const default_save_name: String = "New Save"

func _ready():
	save_data.save_name = "Test Save Data Name"

static func get_new_save_name() -> String:
	var saveName = default_save_name
	var count = 2
	var path = get_save_path(saveName)
	
	while FileAccess.file_exists(path):
		saveName = default_save_name + " (" + str(count) + ")"
		path = get_save_path(saveName)
		count += 1
	
	return saveName

static func change_save_name(some_save_data: SaveData, new_save_name: String) -> void:
	var path = Save.get_save_path(some_save_data.save_name)
	some_save_data.save_name = new_save_name

	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(Save.get_save_path(some_save_data.save_name))
	
	Save.save_specific_data(some_save_data)

static func get_save_path(save_name: String) -> String:
	return save_directory + save_name + ".tres"

func save() -> void:
	Save.save_specific_data(self.save_data)

func load(save_name: String) -> void:
	var path = Save.get_save_path(save_name)
	if FileAccess.file_exists(path):
		self.save_data = ResourceLoader.load(path)
	else:
		self.save_data = SaveData.create_new()
		self.save_data.save_name = save_name
		save()

static func save_specific_data(some_save_data: SaveData) -> void:
	ResourceSaver.save(some_save_data, Save.get_save_path(some_save_data.save_name), ResourceSaver.FLAG_NONE)
