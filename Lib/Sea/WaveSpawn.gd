extends Node
var random = RandomNumberGenerator.new()


const wave_scene = preload("res://Lib/Sea/Wave.tscn")


var wave_position_x = 2000


func _ready():
	for i in range(0,8):
		var wave = wave_scene.instantiate()
		add_child(wave)
		wave.global_position = Vector2(random.randf_range(100,1920), random.randf_range(400,800))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func choose_random_from_array(array_to_choose_from):
	var random_index = randi() % array_to_choose_from.size()
	return array_to_choose_from[random_index]

func spawn_wave():
	var wave = wave_scene.instantiate()
	add_child(wave)
	wave.global_position = Vector2(wave_position_x, random.randf_range(400,800))


func _on_wave_timer_timeout():
	spawn_wave()
