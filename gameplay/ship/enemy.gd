extends Node2D

@export var speed := 60.0
@export var damage := 10.0

func _process(delta: float) -> void:
	var dir := -global_position.normalized()
	global_position += dir * speed * delta


func _on_area_2d_area_entered(area):
	var ship = area.get_parent()
	if ship != null and ship.has_method("apply_damage"):
		ship.apply_damage(damage)
	queue_free()
