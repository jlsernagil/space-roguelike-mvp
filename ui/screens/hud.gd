extends Control

@onready var label: Label = $HudLabel

var ship: Node = null
var battle_controller: Node = null

func _ready() -> void:
	ship = get_parent().get_parent().get_node("Entities/PlayerShip")
	battle_controller = get_parent().get_parent().get_node("BattleController")

func _process(_delta: float) -> void:
	if ship == null:
		label.text = "GAME OVER"
		return

	var hull = ship.hull
	var shield = ship.shield
	var interval = battle_controller.spawn_interval
	label.text = "Hull: %d | Shield: %d | Spawn: %.2fs" % [hull, shield, interval]

func _on_pause_button_pressed() -> void:
	var bc = get_parent().get_parent().get_node("BattleController")
	bc.toggle_pause("button")
