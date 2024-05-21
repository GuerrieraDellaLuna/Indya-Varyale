class_name BookUI
extends Control

@export var book_data: BookData

var page_number_label: Label;
var page_title_label: Label;
var page_description_label: Label;
var flip_left_button: Button;
var flip_right_button: Button;

static func create_new(book_data_from: BookData) -> BookUI:
	var new_book_ui = preload("res://scenes/book.tscn").instantiate();
	new_book_ui.book_data = book_data_from
	return new_book_ui

func _ready():
	page_number_label = %"Page Number";
	page_title_label = %"Page Title";
	page_description_label = %Description;
	flip_left_button = %"Flip Left";
	flip_right_button = %"Flip Right";
	
	update_page();

func update_title(new_title: String) -> void:
	page_title_label.text = new_title;
	return;
	
func update_description(new_description: String) -> void:
	page_description_label.text = new_description;
	return;
	
func update_page_number(new_page_number: int) -> void:
	page_number_label.text = str(new_page_number);
	return;

func update_buttons() -> void:
	flip_left_button.disabled = not book_data.can_flip_page_left();
	flip_right_button.disabled = not book_data.can_flip_page_right();
	
	print("flip left button disabled = ", flip_left_button.disabled)
	print("flip right button disabled = ", flip_right_button.disabled)
		

func update_page():
	var curr_page: Page = book_data.get_current_page();
	update_title(curr_page.page_title);
	update_description(curr_page.page_description);
	update_page_number(curr_page.page_number);
	update_buttons();
	
func _on_flip_left_pressed() -> void:
	book_data.flip_page_left();
	update_page();
	return;

func _on_flip_right_pressed() -> void:
	book_data.flip_page_right();
	update_page();
	return;
