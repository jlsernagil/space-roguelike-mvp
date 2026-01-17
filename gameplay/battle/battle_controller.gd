extends Node

@export var enemy_scene: PackedScene

var spawn_interval := 2.0
var spawn_timer := 0.0
var difficulty_timer := 0.0
var paused := false

func _ready() -> void:
	if enemy_scene == null:
		enemy_scene = preload("res://scenes/battle/enemy.tscn")

func _process(delta: float) -> void:
	spawn_timer += delta
	difficulty_timer += delta

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

	if difficulty_timer >= 3.0:
		difficulty_timer = 0.0
		spawn_interval = max(0.3, spawn_interval * 0.95)

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	var radius := 300.0
	var angle := randf() * TAU
	enemy.global_position = Vector2(cos(angle), sin(angle)) * radius
	get_parent().get_node("Entities/Enemies").add_child(enemy)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_toggle"):
		toggle_pause("keyboard")

func toggle_pause(source: String) -> void:
	paused = !paused
	get_tree().paused = paused
