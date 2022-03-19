extends Area2D

onready var sprite=$Sprite


func _ready():
	CambiarFrame(false)

func CambiarFrame(entro):
	if entro:
		sprite.frame=1
	else:
		sprite.frame=0
		
