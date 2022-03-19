extends KinematicBody2D

const moveSpeed=25;
const maxSpeed=55;
const jumpHeigth=-300;
const up=Vector2(0,-1);
const gravity=15
var motion=Vector2()
onready var sprite=$AnimatedSprite
var saltoDoble=false
var agua=false

func _physics_process(delta):
	motion.y+=gravity	
	GetInput()
	MoveBox()
	motion=move_and_slide(motion,up)

func GetInput():
	var friction=false
	if Input.is_action_pressed("ui_right"):
		sprite.play("Walk")
		sprite.flip_h=false
		motion.x=min(motion.x+moveSpeed,maxSpeed)
	elif Input.is_action_pressed("ui_left"):
		sprite.play("Walk")
		sprite.flip_h=true
		motion.x=max(motion.x-moveSpeed,-maxSpeed)
	else:
		sprite.play("Idle")
		friction=true
	if is_on_floor():
		saltoDoble=true
		if Input.is_action_just_pressed("ui_up"):
			motion.y=jumpHeigth
		if friction==true:
			motion.x=lerp(motion.x,0,0.5)
	else:
		sprite.play("Jump")
		if (Input.is_action_just_pressed("ui_up") && saltoDoble==true) || (Input.is_action_just_pressed("ui_up") && agua==true):
			sprite.play("JumpDouble")
			saltoDoble=false
			motion.y=jumpHeigth+80
		if friction==true:
			motion.x=lerp(motion.x,0,0.01)

func MoveBox():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name== "Box":
			collision.collider.Slide(-collision.normal*(moveSpeed))

func InWater(varInWater):
	agua=varInWater
