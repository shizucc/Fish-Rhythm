extends Node2D

@onready var pancing_lurus = load("res://Assets/Visual/Fishing-Rod/pancing lurus.png")
@onready var pancing_tarik = load("res://Assets/Visual/Fishing-Rod/pancing tarik.png")
@onready var pancing_tarik_kiri = load("res://Assets/Visual/Fishing-Rod/pancing tarik kiri.png")
@onready var pancing_tarik_kanan = load("res://Assets/Visual/Fishing-Rod/pancing tarik kanan.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.game_phase == 0:
		$FishingRodTexture.set_texture(pancing_lurus)
		modulate.a = 0
	elif Global.game_phase == 1:
		modulate.a = 1
	elif Global.game_phase == 2:
		$FishingRodTexture.set_texture(pancing_tarik)
