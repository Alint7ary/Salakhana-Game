extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -350.0

@onready var hit_box: Area2D = $HitBox
@onready var hitbox_shape: CollisionShape2D = $HitBox/CollisionShape2D

var glide_bar: ProgressBar = null

@onready var anime: AnimatedSprite2D = $AnimatedSprite2D
@onready var glide_timer: Timer = $GlideTimer

func _physics_process(delta: float) -> void:
	# Define if we are currently in the "Glide/Hover" state
	var is_gliding = Input.is_action_pressed("glide") and not glide_timer.is_stopped() and not is_on_floor()

	# 1. Gravity Logic
	if not is_on_floor():
		if is_gliding:
			# Stay in place vertically
			velocity.y = 0 
		else:
			# Fall normally
			velocity += get_gravity() * delta
	else:
		glide_timer.stop()

	# 2. Jump Logic
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Glide Activation
	if Input.is_action_just_pressed("glide") and not is_on_floor() and glide_timer.is_stopped():
		glide_timer.start()

	# 4. Horizontal Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anime.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 5. Animation Controller
	if is_gliding:
		anime.play("glide")
	elif not is_on_floor():
		anime.play("jump_up")
	elif velocity.x != 0:
		anime.play("run")
	else:
		anime.play("idle")
	move_and_slide()
func die():
	get_tree( ).reload_current_scene()
