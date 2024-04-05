extends Node2D

@onready var note_perfect = load("res://Assets/Text/note-perfect.png")
@onready var note_great = load("res://Assets/Text/note-great.png")
@onready var note_good = load("res://Assets/Text/note-good.png")
@onready var note_miss = load("res://Assets/Text/note-miss.png")

var hit_type = 0 # 3, 2, 1, 0 for perfect, great, good, and miss respectively

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(770, 100)
	
	match hit_type:
		3:
			$Texture.set_texture(note_perfect)
		2:
			$Texture.set_texture(note_great)
		1:
			$Texture.set_texture(note_good)
		0:
			$Texture.set_texture(note_miss)
	
	await get_tree().create_timer(0.5).timeout
	queue_free()

	
func set_hit_type(new_hit_type: int):
	hit_type = new_hit_type
