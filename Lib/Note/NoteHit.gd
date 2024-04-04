extends Area2D



var keyboard_must_hit = null


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			print(event.keycode)


func _on_area_entered(area):
	if(area.has_method("get_keyboard_note")):
		print(area.get_keyboard_note())
	
