extends Node

const note_scene = preload("res://Lib/Note/Note.tscn")

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0

var interval = 0
var speed = 0

var instance
var spawn_in_measure = [false, false, false, false] # to keep track of which measure to spawn note in

signal interval_signal(interval)

func _ready():
	
	pass # Replace with function body.


func _process(delta):
	pass

func spawn_note():
	var note = note_scene.instantiate()
	add_child(note)

func _on_conductor_measure_signal(position):
	if spawn_in_measure[position-1] and (Global.game_phase == 1 or Global.game_phase == 2 or Global.game_phase == 3):
		spawn_note()

func _on_conductor_beat_signal(position):
	song_position_in_beats = position
	if Global.cur_song == 0: # calm song mapping
		if song_position_in_beats > 3:
			spawn_in_measure = [false, true, false, false]
	elif Global.cur_song == 1: # intense song mapping
		if song_position_in_beats >= 216:
			spawn_in_measure = [true, true, true, false]
		elif song_position_in_beats >= 192:
			spawn_in_measure = [true, false, false, false]
		elif song_position_in_beats >= 160:
			spawn_in_measure = [true, true, true, false]
		elif song_position_in_beats >= 128:
			spawn_in_measure = [true, false, true, false]
		elif song_position_in_beats >= 122:
			spawn_in_measure = [true, false, false, false]
		elif song_position_in_beats >= 116:
			spawn_in_measure = [true, false, true, false]
		elif song_position_in_beats >= 106:
			spawn_in_measure = [true, true, false, true]
		elif song_position_in_beats >= 58:
			spawn_in_measure = [true, false, false, false]
		elif song_position_in_beats >= 52:
			spawn_in_measure = [true, false, true, false] 
		elif song_position_in_beats >= 42:
			spawn_in_measure = [true, true, false, true]
		elif song_position_in_beats > 0:
			spawn_in_measure = [true, false, false, false]
