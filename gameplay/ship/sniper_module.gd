extends Node
class_name SniperModule

enum TargetMode { NEAREST, LOWEST_HULL, MANUAL }

@export var energy_per_charge: float = 40.0
@export var charges_max: int = 1
@export var damage: float = 35.0
@export var range: float = 9999.0
@export var mode: TargetMode = TargetMode.NEAREST

var energy_buffer: float = 0.0
var charges: int = 0
var selected_target: Node2D = null

func receive_energy(amount: float) -> void:
	if charges >= charges_max:
		return
	energy_buffer += amount
	while energy_buffer >= energy_per_charge and charges < charges_max:
		energy_buffer -= energy_per_charge
		charges += 1
		EventBus.emit_event(C.E_BATTLE_MODULE_CHARGE_COMPLETED, {
			"module": self
		})

func can_fire() -> bool:
	return charges > 0 and selected_target != null and is_instance_valid(selected_target)

func consume_charge() -> void:
	charges = max(0, charges - 1)
