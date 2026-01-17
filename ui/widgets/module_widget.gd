extends HBoxContainer

@export var module_name := "Module"
@export var charge_speed := 20.0 # % por segundo
@export var charges_max := 1
@export var ammo_max := -1 # -1 = sin munición

var charge_pct := 0.0
var charges := 0
var ammo := -1

@onready var state_label: Label = $StateLabel
@onready var execute_button: Button = $ExecuteButton

func _ready() -> void:
	execute_button.text = "Ejecutar"
	ammo = ammo_max
	update_text()

func _process(delta: float) -> void:
	if charges < charges_max:
		charge_pct += charge_speed * delta
		if charge_pct >= 100.0:
			charge_pct = 0.0
			charges += 1
	update_text()

func _on_execute_button_pressed() -> void:
	if charges <= 0:
		return
	if ammo_max >= 0 and ammo <= 0:
		return

	charges -= 1
	if ammo_max >= 0:
		ammo -= 1

	# Por ahora solo “dispara” a nivel UI. Luego emitiremos evento y haremos daño real.
	update_text()

func update_text() -> void:
	var ammo_text := "-" if ammo_max < 0 else str(ammo) + "/" + str(ammo_max)
	state_label.text = "%s | Carga: %.0f%% | Cargas: %d/%d | Mun: %s" % [
		module_name, charge_pct, charges, charges_max, ammo_text
	]
