extends KinematicBody2D

export var speed = 80
export var jump_speed = 100

var move_state
var jump_state
var velocity

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	move_state = "idle"
	jump_state = "grounded"
	velocity = Vector2()


func _physics_process(delta):
	var accel = Vector2()
	
	# Run
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		move_state = "run"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		move_state = "run"
	else:
		move_state = "idle"
		velocity.x = 0
		
	# Jump
	if Input.is_action_pressed("ui_up") and jump_state == "grounded":
		jump_state = "airborne"
		velocity.y -= jump_speed
	
	accel.y += ProjectSettings.get_setting("physics/2d/default_gravity")
	
	velocity += accel * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
		
	match(is_on_floor()):
		true: jump_state = "grounded"
		false: jump_state = "airborne"
	
func _process(delta):
	match(move_state):
		"run":
			$AnimatedSprite.animation = "run"
			$AnimatedSprite.flip_h = (velocity.x <= 0)
		"idle":
			$AnimatedSprite.animation = "idle"

	position += velocity * delta
	
	
