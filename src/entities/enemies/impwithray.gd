extends Enemy

@onready var vision = $Vision

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")
	pass # Replace with function body.
	var raycount := cone_vision_angle / angle_between
	for i in raycount:
		var ray = RayCast2D.new()
		var angle := angle_between * (i - raycount / 2.0)
		ray.target_position = Vector2.UP.rotated(angle) * max_view_distance
		vision.add_child(ray)
	pass

var cone_vision_angle := deg_to_rad(45.0)
var max_view_distance := 80.0
var angle_between := deg_to_rad(5.0)
var chase = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for ray in vision.get_children():
		if ray is RayCast2D:
			if ray.is_colliding() and ray.get_collider() == player:
				var direction :Vector2= player.position - self.position
				var direction_degree = rad_to_deg(direction.angle())
				vision.set_global_rotation_degrees(direction_degree + 90)
				chase = true
			else:
				chase = false
			print(chase)
	var direction :Vector2= player.position - self.position
	if chase == true and direction.length() > 50:
		velocity = direction.normalized() * 100
		print(player.velocity)
		print(velocity)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 5)
	
	move_and_slide()
