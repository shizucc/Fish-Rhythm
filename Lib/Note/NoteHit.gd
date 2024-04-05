extends Area2D



var keyboard_must_hit = null


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.is_pressed():
			$NoteHit.set_disabled(false)
			Global.keyboard_note_registered = event
			#print(Global.keyboard_note_registered)
			#print(event)
	
		elif event.is_released():
			$NoteHit.set_disabled(true)
	
	#if event is InputEventKey:
		#if event.is_action_pressed(keyboard_must_hit):
			#$NoteHit.set_disabled(false)
			#print("Sesuai")
		#elif event.is_action_released(keyboard_must_hit):
			#$NoteHit.set_disabled(true)

func _on_note_in_area_area_entered(area):
	pass
	#if(area.has_method("get_keyboard_note")):
		#keyboard_must_hit = area.get_keyboard_note()
		#print(keyboard_must_hit)


func _on_area_entered(area):
	pass # Replace with function body.
