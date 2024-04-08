extends Node2D

@export var fish_amount := 8
var fishes = []
var tricked_fish = null
var tricked_fish_index = -1
var trick_state = false
var fish_scene = preload("res://Lib/Sea/Fish.tscn")

# MENGATUR IKAN RANDOM AGAR TERPERANGKAP PANCING
func set_tricked_fish(value):
	if value == trick_state:
		return
	if(value==true):
		tricked_fish_index = choose_random_index_from_array(fishes)
		if(tricked_fish_index >= 0):
			tricked_fish = fishes[tricked_fish_index]
			tricked_fish.set_tricked(true)
	elif(value==false):
		tricked_fish.set_tricked(false)
		tricked_fish = null
	trick_state = value
# MENGATUR IKAN AGAR MENGHILANG KETIKA STRIKE
func set_strike_fish():
	if(tricked_fish_index >= 0):
		print("STRIKE")
		tricked_fish = fishes[tricked_fish_index]
		fishes.remove_at(tricked_fish_index)
		tricked_fish.queue_free()
		tricked_fish = null
		tricked_fish_index = -1
		trick_state = false

func _ready():
	init_fish(fish_amount)
	
	
func init_fish(amount):
	for i in range(0,amount):
		var fish = fish_scene.instantiate()
		fishes.append(fish)
		add_child(fish)
		
func choose_random_index_from_array(array_to_choose_from):
	var random_index = randi() % array_to_choose_from.size()
	return random_index
	
func _on_fish_timeout_timeout():
	var deleted_fish_index = choose_random_index_from_array(fishes)
	if(deleted_fish_index >= 0):
		var deleted_fish = fishes[deleted_fish_index]
		if(!deleted_fish.TRICKED):
			deleted_fish.change_state_to_disappear()
			fishes.remove_at(deleted_fish_index)
			if deleted_fish_index < tricked_fish_index:
				tricked_fish_index -= 1
	
	await get_tree().create_timer(5).timeout
	if(fishes.size() < 10):
		init_fish(1)
