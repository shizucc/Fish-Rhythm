extends Node2D

var song_position = 0.0
var song_position_in_beats = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Conductor.play_with_beat_offset(8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

