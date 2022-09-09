extends KinematicBody2D

#Constantes de la fisica del jugador
const moveSpeed=80;
const maxSpeed=100;
const jumpHeigth=-310;
const up=Vector2(0,-1);
const gravity=16

export var friction=400
export var acceleration=400

var motion=Vector2()
var saltoDoble=false
var agua=false

onready var animationTree=$AnimationTree
onready var animationState=animationTree.get("parameters/playback")

#Funcion que controla las fisicas del jugador
func _physics_process(delta):
	motion.y+=gravity
	Move_state(delta)
	MoveBox()
	move()

#Funcion para el movimiento y animacion del jugador
func Move_state(delta):
	var input_vector=Vector2.ZERO
	input_vector.x=Input.get_action_raw_strength("ui_right")-Input.get_action_strength("ui_left")
	#input_vector.y=Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector=input_vector.normalized()#Nos moveremos en la misma velocidad en cualquier direccion
	if input_vector!=Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position",input_vector)
		animationTree.set("parameters/Run/blend_position",input_vector)
		animationTree.set("parameters/Jum/blend_position",input_vector)
		animationTree.set("parameters/Jum2/blend_position",input_vector)
		animationTree.set("parameters/Ducking/blend_position",input_vector)
		#animationTree.set("parameters/Looking/blend_position",input_vector)
		if is_on_floor():
			animationState.travel("Run")
		motion=motion.move_toward(input_vector*maxSpeed,acceleration*delta)
	elif is_on_floor():
		animationState.travel("Idle")
		motion=motion.move_toward(Vector2.ZERO,friction*delta)
		if Input.is_action_pressed("ui_down"):
			animationState.travel("Ducking")
	if is_on_floor():#SI el jugador se encuentra en el piso
		saltoDoble=true
		if Input.is_action_just_pressed("ui_up"):
			animationState.travel("Jum")
			motion.y=jumpHeigth
			#motion=motion.move_toward(input_vector*maxSpeed,acceleration*delta)		
	else:
		if (Input.is_action_just_pressed("ui_up") && saltoDoble==true) || (Input.is_action_just_pressed("ui_up") && agua==true):
			animationState.travel("Jum2")
			saltoDoble=false
			motion.y=jumpHeigth+80

func move():
	motion=move_and_slide(motion,up)

func MoveBox():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name== "Box":
			collision.collider.Slide(-collision.normal*(moveSpeed))

func InWater(varInWater):
	agua=varInWater

func Looking():
	animationState.travel("Looking")
