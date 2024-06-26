extends AudioStreamPlayer

@export var bpm := 185
@export var measures := 4

var song_position = 0.0
var song_position_in_beats = 1
var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

var closest = 0
var time_off_beat = 0.0

signal beat_signal(position)
signal measure_signal(position)

func _ready():
	sec_per_beat = 60.0 / bpm
	
	
func _physics_process(delta):
	if Global.score >= Global.strike_score and Global.game_phase == 1:
		stop()
		print("Change to intense music")
		Global.cur_song = 1
		play_with_beat_offset(5)
		Global.game_phase = 2
	if (Global.game_phase == 4 or Global.game_phase == 5 or Global.game_phase == 99) and playing:
		stop()
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
		_report_beat()
	
func _report_beat():
	if last_reported_beat - song_position_in_beats >= 100: # when music has looped
		last_reported_beat = 0
		measure = 4
	if last_reported_beat < song_position_in_beats:
		if measure > measures:
			measure = 1
		emit_signal("beat_signal", song_position_in_beats)
		emit_signal("measure_signal", measure)
		last_reported_beat = song_position_in_beats
		measure += 1

func play_with_beat_offset(num):
	# Set song selection
	var selected_song = Global.song_selection[Global.cur_song]
	set_stream(selected_song["res"])
	
	# Set timing
	bpm = selected_song["bpm"]
	song_position = 0.0
	song_position_in_beats = 0
	sec_per_beat = 60.0 / bpm
	last_reported_beat = 0
	measure = 1
	beats_before_start = num
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()


func _on_start_timer_timeout():
	song_position_in_beats += 1
	if song_position_in_beats < beats_before_start - 1:
		$StartTimer.start()
	elif song_position_in_beats == beats_before_start - 1:
		$StartTimer.wait_time = $StartTimer.wait_time - (AudioServer.get_time_to_next_mix() +
														AudioServer.get_output_latency())
		$StartTimer.start()
	else:
		play()
		$StartTimer.stop()
	_report_beat()
