extends Area2D

func _on_Dialogo_body_entered(body):
	if body.name=="Player" && Input.is_action_just_pressed("ui_accept"):
		body.Looking()
		print("Entro")


func _on_Dialogo_body_exited(body):
	pass # Replace with function body.

