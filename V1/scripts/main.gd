extends Node3D

var ui_container: Control;
var book_data: BookData;
var book_ui: BookUI;

var can_open_book: bool = true;
var book_open: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_container = %"UI Container";
	
	book_data = BookData.create_new();
	book_ui = BookUI.create_new(book_data);
	book_ui.hide();
	ui_container.add_child(book_ui, false, Node.INTERNAL_MODE_DISABLED);

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
