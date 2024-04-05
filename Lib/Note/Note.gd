extends Node2D

@onready var note_W = load("res://Assets/Notes/note_w.png")
@onready var note_A = load("res://Assets/Notes/note_a.png")
@onready var note_S = load("res://Assets/Notes/note_s.png")
@onready var note_D = load("res://Assets/Notes/note_d.png")
@onready var note_up = load("res://Assets/Notes/note_up.png")
@onready var note_dw = load("res://Assets/Notes/note_dw.png")
@onready var note_lf= load("res://Assets/Notes/note_lf.png")
@onready var note_rg = load("res://Assets/Notes/note_rg.png")


@onready var notes = [
	{"note" : note_W, "keyboard" : "note_w" },
	{"note" : note_A, "keyboard" : "note_a" },
	{"note" : note_S, "keyboard" : "note_s" },
	{"note" : note_D, "keyboard" : "note_d" },
	{"note" : note_up, "keyboard" : "note_up" },
	{"note" : note_dw, "keyboard" : "note_down" },
	{"note" : note_lf, "keyboard" : "note_left" },
	{"note" : note_rg, "keyboard" : "note_right" },
]

@onready var hit_symbol = preload("res://Lib/HitSymbol/HitSymbol.tscn")

@onready var TARGET_X = Global.song_selection[Global.cur_song]["target_x"]
@onready var SPAWN_X = 1600
@onready var SPAWN_POS = Vector2(SPAWN_X, 145)
@onready var DISTANCE = TARGET_X - SPAWN_X

var speed = 0

var chosen_note = null

enum NOTE_STATES {
	RUN,
	STOP_AND_DISAPEAR,
	RUN_AND_DISAPEAR
}
var note_state = NOTE_STATES.RUN

var score = null

func _ready():
	position = SPAWN_POS
	speed = DISTANCE / 2.0
	chosen_note = choose_random_note(notes)
	$NoteSymbol.set_texture(chosen_note["note"])
	

func _physics_process(delta):
	match note_state:
		NOTE_STATES.RUN :
			position.x += speed * delta
		NOTE_STATES.STOP_AND_DISAPEAR:
			pass
	
func _process(delta):
	if position.x <= 600:
		Global.score -= 4
		spawn_hit_symbol(0)
		queue_free()

func choose_random_note(array_to_choose_from):
	var random_index = randi() % array_to_choose_from.size()
	return array_to_choose_from[random_index]

func get_chosen_note():
	return chosen_note

func _on_good_area_area_entered(area):
	var keyboard_must_press = Global.keyboard_note_registered
	if(InputMap.action_has_event(chosen_note["keyboard"], keyboard_must_press)):
		Global.score += 1
		spawn_hit_symbol(1)
		queue_free()


func _on_great_area_area_entered(area):
	var keyboard_must_press = Global.keyboard_note_registered
	if(InputMap.action_has_event(chosen_note["keyboard"], keyboard_must_press)):
		Global.score += 2
		spawn_hit_symbol(2)
		queue_free()


func _on_perfect_area_area_entered(area):
	var keyboard_must_press = Global.keyboard_note_registered
	if(InputMap.action_has_event(chosen_note["keyboard"], keyboard_must_press)):
		Global.score += 3
		spawn_hit_symbol(3)
		queue_free()
	

func spawn_hit_symbol(hit_type: int):
	# 3, 2, 1, 0 for perfect, great, good, and miss respectively
	var new_hit_symbol = hit_symbol.instantiate()
	new_hit_symbol.set_hit_type(hit_type)
	get_parent().add_child(new_hit_symbol)
