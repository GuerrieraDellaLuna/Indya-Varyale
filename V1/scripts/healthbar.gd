class_name HealthBar extends ProgressBar

signal died();

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var health = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		died.emit()
		return
		
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Health Bar Initialized")
	anchor_left = 1.0
	anchor_top = 0.0
	anchor_right = 1.0
	anchor_bottom = 0.0

	offset_left = -150
	offset_top = 10
	offset_right = -10
	offset_bottom = 30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	damage_bar.value = health
