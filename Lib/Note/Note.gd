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


const TARGET_X = 770
const SPAWN_X = 1500
const SPAWN_POS = Vector2(SPAWN_X, 145)
const DISTANCE = TARGET_X - SPAWN_X

var speed = 0

var chosen_note = null



var score = null

func _ready():
	chosen_note = choose_random_note(notes)
	$NoteInitArea.keyboard_note = chosen_note["keyboard"]
	$NoteSymbol.set_texture(chosen_note["note"])

func _physics_process(delta):
	position.x += speed * delta
	

func initialize():
	position = SPAWN_POS
	speed = DISTANCE / 2.0

func choose_random_note(array_to_choose_from):
	var random_index = randi() % array_to_choose_from.size()
	return array_to_choose_from[random_index]

func get_chosen_note():
	return chosen_note

func _on_good_area_area_entered(area):
	print("good")
	score = "good"
	queue_free()


func _on_great_area_area_entered(area):
	print("great")
	score = "great"
	queue_free()


func _on_perfect_area_area_entered(area):
	print("perfect")
	score = "perfect"
	queue_free()
