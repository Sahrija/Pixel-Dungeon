extends Enemy


@export var MOVE_SPEED := 70
var vision_area := 200
@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $"../../Player"
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var location : Vector2 = player.position - self.position
	var direction = location.normalized()
	if location.length() < vision_area :
		velocity = velocity.move_toward(direction * MOVE_SPEED, 10)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 10)
	if velocity != Vector2.ZERO:
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		anim.play("run")
	else:
		anim.play("idle")
	move_and_slide()

func kill():
	super.kill()
	print("death noises")
	pass
