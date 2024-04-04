extends Node

const note_scene = preload("res://Lib/Note/Note.tscn")

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0

var interval = 0
var speed = 0

var instance
var note = load("res://Lib/Note/Note.tscn")
var spawn_in_measure = [false, false, false, false] # to keep track of which measure to spawn note in

signal interval_signal(interval)

func _ready():
	
	pass # Replace with function body.


func _process(delta):
	pass

func spawn_note():
	var note = note_scene.instantiate()
	note.initialize()
	add_child(note)

func _on_conductor_measure_signal(position):
	if spawn_in_measure[position-1]:
		spawn_note()

func _on_conductor_beat_signal(position):
	song_position_in_beats = position
	if song_position_in_beats > 0:
		spawn_in_measure = [true, false, false, false]

func _spawn_notes(count, interval):
	spawn_note()
