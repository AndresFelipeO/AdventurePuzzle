extends Area2D

func _on_water_body_entered(body):
	if(body.name=="Player"):
		body.InWater(true)

func _on_water_body_exited(body):
	if(body.name=="Player"):
		body.InWater(false)
