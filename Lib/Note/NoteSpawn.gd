extends Node

const note_scene = preload("res://Lib/Note/Note.tscn")

var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0

var interval = 0
var speed = 0

var instance
var note = load("res://Lib/Note/Note.tscn")

signal interval_signal(interval)

func _ready():
	
	pass # Replace with function body.


func _process(delta):
	pass

func spawn_note():
	var note = note_scene.instantiate()
	add_child(note)
	note.global_position = Vector2(1500,145)

func _on_conductor_measure_signal(position):
	if(position % interval == 0):
		spawn_note()

func _on_conductor_beat_signal(position):
	song_position_in_beats = position
	if song_position_in_beats < 41 :
		interval = 5
	elif song_position_in_beats > 41 and song_position_in_beats < 52 :
		pass
		

func _spawn_notes(count, interval):
	spawn_note()
	
	
func _on_note_timer_timeout():
	print("timeout")
	spawn_note()
