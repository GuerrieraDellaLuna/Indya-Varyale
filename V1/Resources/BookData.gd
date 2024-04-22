class_name BookData
extends Resource

@export var unlocked_pages: Array;
@export var current_page: int = 0;
const first_item_page_number: int = 40;

func get_first_item_page_index() -> int:
	return unlocked_pages.bsearch_custom(
		first_item_page_number, 
		func(arr_val: Page, search: int): arr_val.page_number < search,
		true);

func add_page(page_number: int) -> void:
	var page = Page.from_number(page_number);
	for i in range(len(unlocked_pages) - 1):
		if unlocked_pages[i].page_number < page_number:
			unlocked_pages.insert(i, page);
			return;
	
	unlocked_pages.insert(len(unlocked_pages), page);
	
func flip_page_right() -> void:
	current_page = min(len(unlocked_pages)-1, current_page+1);
	print("flipped right, new page = ", current_page)

func can_flip_page_right() -> bool:
	return current_page < len(unlocked_pages)-1;
	
func flip_page_left() -> void:
	current_page = max(0, current_page-1);
	
func can_flip_page_left() -> bool:
	return current_page > 0;

func get_current_page() -> Page:
	return unlocked_pages[current_page];
	
static func create_new() -> BookData:
	var new_book_data = BookData.new();
	# initial pages
	new_book_data.unlocked_pages.append(ResourceLoader.load("res://Resources/Pages/page_1.tres"));
	new_book_data.unlocked_pages.append(ResourceLoader.load("res://Resources/Pages/page_3.tres"));
	new_book_data.unlocked_pages.append(ResourceLoader.load("res://Resources/Pages/page_40.tres"));
	
	return new_book_data;

