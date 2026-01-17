extends Node

class_name ReactorModule

@export var energy_per_sec: float = 25.0

func produce(delta: float) -> float:
	return energy_per_sec * delta
