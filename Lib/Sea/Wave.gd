extends Node2D


@onready var wave1 = preload("res://Assets/Visual/Sea/gelombang1.png")
@onready var wave2 = preload("res://Assets/Visual/Sea/gelombang2.png")
@onready var wave3 = preload("res://Assets/Visual/Sea/gelombang3.png")

@onready var waves = [wave1, wave2, wave3]



var speed = randi_range(75,100)



# Called when the node enters the scene tree for the first time.
func _ready():
	var selected_wave = choose_random_from_array(waves)
	$Wave.set_texture(selected_wave)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta





func _on_area_entered(area):
	queue_free()
func choose_random_from_array(array_to_choose_from):
	var random_index = randi() % array_to_choose_from.size()
	return array_to_choose_from[random_index]
