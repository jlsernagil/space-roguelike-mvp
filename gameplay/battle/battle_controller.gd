extends Node


var battle_viewport: SubViewport
var cam: Camera2D

var world: Node2D
var entities: Node2D
var ship: Node2D
var enemies_container: Node2D
var fx: Node2D

var spawn_interval := 2.0
var spawn_timer := 0.0
var difficulty_timer := 0.0
var paused := false

@onready var enemy_scene: PackedScene = preload("res://scenes/battle/enemy.tscn")

func _ready() -> void:

	var scene_root := get_parent()

	battle_viewport = scene_root.get_node("UI/RootUI/HSplitContainer/BattlePanel/Panel/SubViewportContainer/BattleViewport") as SubViewport
	world = battle_viewport.get_node("World") as Node2D

	cam = world.get_node("Camera2D") as Camera2D
	cam.enabled = true

	# Si quieres, deja explícito el viewport para la cámara (opcional, pero ayuda):
	cam.make_current()

	world = scene_root.get_node("UI/RootUI/HSplitContainer/BattlePanel/Panel/SubViewportContainer/BattleViewport/World")
	entities = world.get_node("Entities")
	ship = entities.get_node("PlayerShip")
	enemies_container = entities.get_node("Enemies")
	fx = world.get_node("FX")


func _process(delta: float) -> void:
	spawn_timer += delta
	difficulty_timer += delta

	if ship == null or !is_instance_valid(ship):
		return

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

	if difficulty_timer >= 3.0:
		difficulty_timer = 0.0
		spawn_interval = max(0.3, spawn_interval * 0.95)
	
	if is_instance_valid(ship):
		cam.global_position = ship.global_position

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	var radius := 300.0
	var angle := randf() * TAU
	enemy.global_position = ship.global_position + Vector2(cos(angle), sin(angle)) * radius
	enemies_container.add_child(enemy)	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_toggle"):
		toggle_pause("keyboard")
		get_viewport().set_input_as_handled()


func toggle_pause(source: String = "") -> void:
	print(source)
	paused = !paused
	get_tree().paused = paused

func _on_pause_button_pressed() -> void:
	var _root = get_parent().get_parent()
	#var bc = root.get_node("BattleController")
	toggle_pause("button")
