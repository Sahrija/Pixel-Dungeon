extends CharacterBody2D
class_name Enemy

var player
var enemies_property : Dictionary = {
	"Imp":{
		"move_speed": 70,
		"atk_dmg": 10
	}
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(self.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func kill():
	self.queue_free()

func take_damage(source: Hitbox):
	if source.KNOCKBACK_FORCE:
		knockback(source)
	if has_node("HealthComponent"):
		var health_component :  = $HealthComponent
		health_component.current_hp -= source.DAMAGE
		print(health_component.current_hp)
		if health_component.current_hp <= 0:
			self.kill()

func knockback(source : Hitbox):
	var knocback_direction = -1 * (source.owner.position - self.position).normalized()
	self.velocity = knocback_direction * source.KNOCKBACK_FORCE
