extends Node2D

var song_position = 0.0
var song_position_in_beats = 0

@onready var strike_bar = $PlayerUI/TextureProgressBar
@onready var reel_text = $PlayerUI/Text
@onready var text_cast = load("res://Assets/Text/reel-cast.png")
@onready var text_strike = load("res://Assets/Text/reel-strike.png")
@onready var text_success = load("res://Assets/Text/reel-success.png")
@onready var text_fail = load("res://Assets/Text/reel-fail.png")
@onready var fish_count_label = $PlayerUI/Label
@onready var reset_btn = $PlayerUI/ResetButton

# Called when the node enters the scene tree for the first time.
func _ready():
	strike_bar.modulate.a = 0
	reel_text.modulate.a = 0
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.game_phase == 0:
		# prepare UI etc
		reset_btn.disabled = true
		strike_bar.modulate.a = 0
		reel_text.set_texture(text_cast)
		reel_text.modulate.a = 1
		fish_count_label.text = str(Global.fish_count)
		if Input.is_action_just_pressed("cast"):
			# set strike score
			var rng = RandomNumberGenerator.new()
			Global.strike_score = rng.randi_range(20, 40)
			
			reel_text.modulate.a = 0 # hide text
			
			# begin song
			Global.cur_song = 0
			$Conductor.play_with_beat_offset(6)
			Global.game_phase = 1
	elif Global.game_phase == 1 and $Conductor.playing:
		reset_btn.disabled = false
	elif Global.game_phase == 2:
		reel_text.set_texture(text_strike)
		reel_text.modulate.a = 1
		Global.score = 50
		strike_bar.value = Global.score
		strike_bar.modulate.a = 1
		await get_tree().create_timer(1.0).timeout
		reel_text.modulate.a = 0
	elif Global.game_phase == 3:
		strike_bar.value = Global.score
		if Global.score >= 200:
			Global.game_phase = 4
		elif Global.score <= 0:
			Global.game_phase = 5
	elif Global.game_phase == 4:
		reel_text.set_texture(text_success)
		reel_text.modulate.a = 1
		Global.fish_count += 1
		fish_count_label.text = str(Global.fish_count)
		Global.game_phase = 99
	elif Global.game_phase == 5:
		reel_text.set_texture(text_fail)
		reel_text.modulate.a = 1
		Global.game_phase = 99
	elif Global.game_phase == 99:
		await get_tree().create_timer(2.0).timeout
		reel_text.modulate.a = 0
		Global.score = 0
		Global.game_phase = 0

func _on_reset_button_pressed():
	Global.fish_count = 0
	Global.game_phase = 99
