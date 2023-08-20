extends Area2D
class_name Hurtbox


func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox and area.owner is Player:
		if owner.has_method("take_damage"):
			owner.take_damage(area)
		elif owner.has_method("kill"):
			owner.kill()
		
