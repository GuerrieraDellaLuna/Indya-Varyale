class_name Page
extends Resource

@export var page_number: int
@export var page_title: String
@export var page_description: String
# Possibly an image later

static func from_number(page_number_from: int) -> Page:
	return ResourceLoader.load("res://Resources/Pages/page_" + str(page_number_from) + ".tres") as Page;
