extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_strike_fish():
	$Fishing/Fishes.set_strike_fish()

func set_tricked_fish(value):
	$Fishing/Fishes.set_tricked_fish(value)
