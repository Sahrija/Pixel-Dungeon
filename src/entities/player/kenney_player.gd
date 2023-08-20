extends CharacterBody2D

var direction : Vector2
@export var MAX_SPEED := 100
@export var ACCELERATION:= 10

@onready var anim = $AnimatedSprite2D
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
var timer = -9
var timer_is_run := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = (Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	)
	if velocity != Vector2.ZERO:
		pass
#		if velocity.x > 0:
#			$AnimatedSprite2D.flip_h = false
#		elif velocity.x < 0:
#			$AnimatedSprite2D.flip_h = true
	else:
		pass
	if direction != Vector2.ZERO:
		animationTree.set("parameters/run/blend_position", direction)
		animationTree.set("parameters/idle/blend_position", direction)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
		animationState.travel("run")
	else:
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION)
	move_and_slide()
	pass
