extends Node3D

const player_scene = preload("res://scenes/player.tscn")

@onready var ui_container: Control = $"UI Container";
@onready var main_menu: MainMenu = $"UI Container/Menu";
@onready var level_container: Node3D = $"Level Container";

var book_ui: BookUI;

var can_open_book: bool = true;
var book_open: bool = false;
var current_level

# Called when the node enters the scene tree for the first time.
func _ready():
	Save.save_data.book = BookData.create_new();
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event.is_action_pressed("inventory"):
		get_viewport().set_input_as_handled();
		if (book_open):
			close_book();
		elif can_open_book:
			open_book();
		return
	
	if event.is_action_pressed("menu toggle"):
		get_viewport().set_input_as_handled();
		if (book_open):
			close_book();
			
		return
		# open pause menu when implemented
	
	if event.is_action_pressed("open test dialogue"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/stage1.dialogue"), "test")
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		return
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func open_book() -> void:
	book_open = true;
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	book_ui.show();
	return;
	
func close_book() -> void:
	book_open = false;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED	
	book_ui.hide();
	return;
	
func get_current_level():
	return current_level

func get_player() -> Player:
	if current_level == null:
		printerr("Tried to get player, but current_level is null")
		return null
	
	if not current_level.has_method("get_player"):
		printerr("Tried to get player, but current_level doesn't have method get_player")
		return null
	
	return current_level.get_player();
	
func _on_menu_start_level(path: String):
	main_menu.hide();
	
	book_ui = BookUI.create_new(Save.save_data.book);
	book_ui.hide();
	ui_container.add_child(book_ui);
	
	var player = player_scene.instantiate();
	player.scale = Vector3(4.5, 4.5, 4.5);
	change_level(path, 0, player);
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	
func change_level(path: String, spawn_point_idx: int, player: Player):
	print("1")
	for child in level_container.get_children():
		print("2")
		child.player_holder.remove_child(player)
		print("3")
		child.queue_free();
	print("4")
	
	print("5")
	var level = load(path).instantiate();
	print("6")
	current_level = level
	print("7")
	level.set_player(player);
	print("8")
	level_container.add_child(level);
	print("9")
	level.spawn_player_in(spawn_point_idx);
	print("10")
