extends CharacterBody2D

var TRICKED = false
# Called when the node enters the scene tree for the first time.
var speed = 50

var rod_target = null

var x_border = {
	"min" : 300,
	"max" : 1200
 }

enum FISH_STATE {
	CHASE,
	NORMAL
}
enum FISH_DIRECTION  {
	RIGHT,
	LEFT
} 

var fish_direction = FISH_DIRECTION.RIGHT
var fish_state = FISH_STATE.NORMAL
func _ready():
	global_position = Vector2(350,650)
	
func change_state_to_chase():
	fish_state = FISH_STATE.CHASE

func change_state_to_normal():
	fish_state = FISH_STATE.NORMAL
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(TRICKED):
		$FishBaitDetection/CollisionShape2D.set_disabled(false)
	else:
		$FishBaitDetection/CollisionShape2D.set_disabled(true)
	
	if(fish_direction == FISH_DIRECTION.RIGHT):
		$FishImg.set_flip_h(true)
	if(fish_direction == FISH_DIRECTION.LEFT):
		$FishImg.set_flip_h(false)
		
	match fish_state:
		FISH_STATE.NORMAL :
			state_normal(delta)
			
		FISH_STATE.CHASE :
			pass
			state_chase(delta, rod_target)

func set_tricked(value):
	TRICKED = value

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

	

func _on_fish_bait_detection_area_entered(area):
	print(area.global_position)
	if(area.name == "BaitArea"):
		rod_target = area
		change_state_to_chase()




