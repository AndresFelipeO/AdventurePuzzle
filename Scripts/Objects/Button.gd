extends Area2D

onready var sprite=$Sprite

func _on_Button_body_entered(body):
	print("ENtro")
	sprite.frame=1

func _on_Button_body_exited(body):
	print("salio")
	sprite.frame=0
