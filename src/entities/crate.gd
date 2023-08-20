extends StaticBody2D
class_name Crate

@onready var WoodBreaksFffect = load("res://effects/wood_breaks.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func kill():
	print('destroyed')
	play_wood_breaks_effect()
	self.queue_free()

func play_wood_breaks_effect():
	var wood_breaks_effect = WoodBreaksFffect.instantiate()
	var world = get_tree().current_scene
	world.add_child(wood_breaks_effect)
	wood_breaks_effect.global_position = global_position
