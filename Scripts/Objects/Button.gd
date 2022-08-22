extends Area2D

onready var sprite=$Sprite

func _on_Button_body_entered(body):
	sprite.frame=1

func _on_Button_body_exited(body):
	sprite.frame=0
