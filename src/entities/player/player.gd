extends CharacterBody2D
class_name Player

@export var MAX_SPEED := 100
@export var ACCELERATION:= 10

@onready var anim = $AnimatedSprite2D
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

var direction : Vector2
var last_direction : Vector2

var current_state = MOVE

@export var HealthComponent : Health


enum {
	IDLE,
	MOVE,
	ROLL,
	ATTACK,
	RECOIL,
}


func _ready() -> void:
	animationTree.active = true
	pass


func _physics_process(delta: float) -> void:
	match current_state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)
		IDLE:
			pass
		RECOIL:
			pass
	
	
	
	move_and_slide()
	
	if attack_buffer_timer > 0:
		attack_buffer_timer -= delta
		
	
	if Input.is_action_just_pressed("attack"):
		attack_buffer_timer = attack_buffer_time
	
	
	pass

var attack_buffer_time = 0.3
var attack_buffer_timer = 0

func move_state(delta):
	# movement input
	set_movement_input()
	
	if velocity != Vector2.ZERO:
		animationState.travel("run")
	else:
		animationState.travel("idle")
	
	
	# attack
	if Input.is_action_just_pressed("attack"):
		pass
		$Attack.play("sword_attack")
#		current_state = ATTACK
	
	set_attack_direction()
	
	movement_flip_sprite()
	
	pass

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("attack_sword_swing")
	pass


func set_attack_direction():
	# set attack direction
	var attack_direction = (get_global_mouse_position() - self.position).normalized()
	$Hitbox.set_rotation(attack_direction.angle())


func movement_flip_sprite():
	if velocity != Vector2.ZERO:
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif direction.x < 0:
			$AnimatedSprite2D.flip_h = true


func set_movement_input():
	direction = (Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	)
	
	if direction != Vector2.ZERO:
		last_direction = direction
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	current_state = MOVE
