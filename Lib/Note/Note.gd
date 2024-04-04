extends CharacterBody2D

const TARGET_X = 700
const SPAWN_X = 1500
const SPAWN_POS = Vector2(SPAWN_X, 145)
const DISTANCE = TARGET_X - SPAWN_X

var speed = 0

func _physics_process(delta):
	position.x += speed * delta

func initialize():
	position = SPAWN_POS
	speed = DISTANCE / 2.0
