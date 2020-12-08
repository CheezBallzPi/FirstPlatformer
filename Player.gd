extends KinematicBody2D

export var speed = 400
export var jump_speed = 600

var velocity

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2()


func _physics_process(delta):
	var accel = Vector2()
	
	# Run
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$AnimatedSprite.animation = "run"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite.animation = "run"
	else:
		velocity.x = 0
		$AnimatedSprite.animation = "idle"
		
	# Jump
	if Input.is_action_pressed("ui_up"):
		accel.y += jump_speed
	
	accel.y -= ProjectSettings.get_setting("physics/2d/default_gravity")
	
	velocity += accel * delta
	velocity = move_and_slide(velocity)
	
func _process(delta):
	position += velocity * delta
	
	
