extends Node2D

var hull := 100
var shield := 50

func apply_damage(amount: float) -> void:
	
	if shield > 0:
		shield -= amount
	else:
		hull -= amount
	print(shield + hull)
	
	if hull <= 0:
		queue_free()
