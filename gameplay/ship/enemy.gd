extends Node2D

@export var speed := 60.0
@export var contact_damage := 10.0

var hull: float = 30.0
var shield: float = 0.0

func _process(delta: float) -> void:
	var dir := -global_position.normalized()
	global_position += dir * speed * delta

func _on_area_2d_area_entered(area):
	var ship = area.get_parent()
	if ship != null and ship.has_method("apply_damage"):
		ship.apply_damage(contact_damage)
	queue_free()
	
func apply_damage(amount: float) -> void:
	if shield > 0:
		var s = min(shield, amount)
		shield -= s
		amount -= s
	if amount > 0:
		hull -= amount
	if hull <= 0:
		queue_free()
