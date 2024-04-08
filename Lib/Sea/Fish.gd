extends CharacterBody2D

var TRICKED = false
# Called when the node enters the scene tree for the first time.
var speed = randf_range(30,60)

var rod_target = null

var x_border = {
	"min" : 300,
	"max" : 1200
 }

enum FISH_STATE {
	SUMMON,
	CHASE,
	NORMAL,
	DISAPPEAR
}
enum FISH_DIRECTION  {
	RIGHT,
	LEFT
} 

var fish_direction = FISH_DIRECTION.RIGHT
var fish_state = FISH_STATE.SUMMON
func _ready():
	$FishImg.modulate.a = 0
	fish_state = FISH_STATE.SUMMON
	global_position = Vector2(randf_range(300,1600),randf_range(400,650))
	
	
func change_state_to_chase():
	fish_state = FISH_STATE.CHASE

func change_state_to_normal():
	fish_state = FISH_STATE.NORMAL
	
func change_state_to_disappear():
	fish_state = FISH_STATE.DISAPPEAR
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(TRICKED):
		$FishBaitDetection/CollisionShape2D.set_disabled(false)
		$FishBaitDetection.set_monitoring(true)
	else:
		$FishBaitDetection/CollisionShape2D.set_disabled(true)
		$FishBaitDetection.set_monitoring(false)
	
	if(fish_direction == FISH_DIRECTION.RIGHT):
		$FishImg.set_flip_h(true)
	if(fish_direction == FISH_DIRECTION.LEFT):
		$FishImg.set_flip_h(false)
		
	match fish_state:
		FISH_STATE.SUMMON :
			state_summon(delta)
		
		FISH_STATE.NORMAL :
			state_normal(delta)
			
		FISH_STATE.CHASE :
			state_chase(delta, rod_target)
		
		FISH_STATE.DISAPPEAR :
			state_disappear(delta)

func set_tricked(value):
	await get_tree().create_timer(1.5).timeout
	TRICKED = value
	
	
func state_summon(delta):
	state_normal(delta)
	if($FishImg.modulate.a < 0.3):
		$FishImg.modulate.a += 0.003
	else:
		fish_state = FISH_STATE.NORMAL

func state_normal(delta):
	if(fish_direction == FISH_DIRECTION.RIGHT):
		velocity.x = speed
		velocity.y = 0
		if(global_position.x >= x_border["max"]):
			fish_direction = FISH_DIRECTION.LEFT

	if(fish_direction == FISH_DIRECTION.LEFT):
		velocity.x = -speed
		velocity.y = 0
		if(global_position.x <= x_border["min"]):
			fish_direction = FISH_DIRECTION.RIGHT

	move_and_slide()
	
func state_chase(delta, target):
	var direction = (target.global_position-global_position).normalized()
	velocity = velocity.move_toward(direction*speed*1.5,150*delta)
	
	if(velocity.x < 0):
		fish_direction = FISH_DIRECTION.LEFT
	else:
		fish_direction = FISH_DIRECTION.RIGHT
	move_and_slide()

func state_disappear(delta):
	state_normal(delta)
	print($FishImg.modulate.a)
	if($FishImg.modulate.a >= 0):
		$FishImg.modulate.a -= 0.003
	else:
		queue_free()

func _on_fish_bait_detection_area_entered(area):
	if(area.name == "BaitArea"):
		rod_target = area
		change_state_to_chase()





