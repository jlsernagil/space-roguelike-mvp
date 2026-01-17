extends Node

@export var battle_scene: PackedScene

func _ready() -> void:
	if battle_scene == null:
		battle_scene = preload("res://scenes/battle/battle_scene.tscn")
	
	var battle = battle_scene.instantiate()
	add_child(battle)
