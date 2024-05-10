extends Node

# Maximum number of monsters
var max_monsters = 10

# The monster scene
var monster_scene = preload("res://scenes/monster.tscn")

# Array to keep track of the monsters
var monsters = []

# Timer for spawning monsters
var spawn_timer = Timer.new()

func _ready():
	# Configure the timer
	spawn_timer.set_wait_time(5)  # Set the timer interval to 10 seconds
	spawn_timer.set_one_shot(false)  # The timer will automatically restart when it times out
	spawn_timer.connect("timeout", _on_spawn_timer_timeout)  # Connect the timer's timeout signal to a function
	add_child(spawn_timer)  # Add the timer as a child of this node
	spawn_timer.start()  # Start the timer

func _on_spawn_timer_timeout():
	if monsters.size() < max_monsters:
		spawn()

func spawn():
	# Instance a new monster
	print("spawned")
	print(len(monsters))
	var monster = monster_scene.instantiate()
	monster.transform.basis = monster.transform.basis.scaled(Vector3(0.006, 0.006, 0.006))
	monster.transform.origin = Vector3(-1.5, 0, -2.5)


	# Add the monster to the scene
	get_parent().add_child(monster)

	# Add the monster to the array
	monsters.append(monster)

