extends CharacterBody3D
@onready var animated_sprite_2d = $CanvasLayer/Weapon/AnimatedSprite2D

const SPEED = 50.0
const MOUSE_SENS = 0.5

var lerpSpeed = 7.0
var direction = Vector3.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		$Camera3D.rotation_degrees.x -= event.relative.y * MOUSE_SENS 
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, deg_to_rad(-70), deg_to_rad(70))
	
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fly"):
		$".".position.y +=10
	if Input.is_action_just_pressed("descend"):
		$".".position.y -=10
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*lerpSpeed)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
