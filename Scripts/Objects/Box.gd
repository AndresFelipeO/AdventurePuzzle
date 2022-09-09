extends KinematicBody2D
class_name Box

export var gravity=200
var velocity=Vector2.ZERO

func _physics_process(_delta):
	velocity.y=gravity
	velocity=move_and_slide(velocity)
	velocity=Vector2.ZERO

func Slide(vector):
	velocity.x=vector.x
		
