extends Node2D

@onready var Anime: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCast_Right
@onready var ray_cast_left: RayCast2D = $RayCast_Left


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction * SPEED * 1 * delta
	Anime.play("goblin_walk")
	if ray_cast_right.is_colliding():
		direction = -1
		Anime.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		Anime.flip_h = false
	
