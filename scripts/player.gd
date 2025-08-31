extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -320.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# Face ca doar podelele cu un unghi < 30° să fie considerate sol
	floor_max_angle = deg_to_rad(30)
	# Dezactivează "lipirea" de podea/perete
	floor_snap_length = 0.0

func _physics_process(delta):
	# Aplică gravitația doar dacă nu e pe podea
	if not is_on_floor():
		velocity.y += gravity * delta

	# Săritura (cu SPACE -> mapează "ui_accept" pe Space în Input Map)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Mișcare stânga-dreapta (A și D)
	var direction := 0
	if Input.is_key_pressed(KEY_A):
		direction -= 1
	if Input.is_key_pressed(KEY_D):
		direction += 1

	velocity.x = direction * SPEED

	# Aplică mișcarea și coliziunile
	move_and_slide()
