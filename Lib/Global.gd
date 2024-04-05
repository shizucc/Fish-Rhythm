extends Node

var score = 0
var cur_song = 0 # 0 for calm music, 1 for intense music

@onready var song_selection = [
	{"res": load("res://Assets/Music/slow_music.mp3"), "bpm": 100, "target_x": 810},
	{"res": load("res://Assets/Music/intense_music.mp3"), "bpm": 185, "target_x": 880}
]

# Called when the node enters the scene tree for the first time.
var keyboard_note_registered = null
func _ready():
	pass # Replace with function body.

func _process(delta):
	print("Score: " + str(score))

func set_cur_song(index: int):
	cur_song = index
