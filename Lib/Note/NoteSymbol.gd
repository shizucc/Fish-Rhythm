extends TextureRect

@onready var note_W = load("res://Assets/Notes/note_w.png")
@onready var note_A = load("res://Assets/Notes/note_a.png")
@onready var note_S = load("res://Assets/Notes/note_s.png")
@onready var note_D = load("res://Assets/Notes/note_d.png")
@onready var note_up = load("res://Assets/Notes/note_up.png")
@onready var note_dw = load("res://Assets/Notes/note_dw.png")
@onready var note_lf= load("res://Assets/Notes/note_lf.png")
@onready var note_rg = load("res://Assets/Notes/note_rg.png")


@onready var notes = [note_W, note_A, note_S, note_D, note_up, note_dw, note_lf, note_rg]
func _ready():
	var chosen_note = choose_random_note(notes)
	set_texture(chosen_note)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func choose_random_note(array_to_choose_from):
	var random_index = randi() % array_to_choose_from.size()
	return array_to_choose_from[random_index]
