extends TileMap

var player_position
var current_item = "crate"

@onready var place_area: Area2D = $"../PlaceArea"

var objects = {
	"crate" : {
		"sceene_file_path": "res://src/entities/crate.tscn",
		"location_path" :"../Crates",
	},
	"imp" : {
		"sceene_file_path": "res://src/entities/enemies/imp.tscn",
		"location_path" :"../Enemy",
	}
}


func _input(event: InputEvent) -> void:
	pass


func place_sceene(object, clicked_map_position):
	if is_colliding() == false:
		var object_instance = load(object.sceene_file_path).instantiate()
		var parent = get_node(object.location_path)
		parent.add_child(object_instance)
		object_instance.position = map_to_local(clicked_map_position)
	print(is_colliding())
	print(clicked_map_position)

func is_colliding():
	if place_area.get_overlapping_bodies() || place_area.get_overlapping_areas():
		return true
	else:
		return false

var place_time = 0.05
var place_timer = place_time

func _physics_process(delta: float) -> void:
	player_position = local_to_map($"../Player".position)
	var mouse_map_position = local_to_map(get_global_mouse_position())
	place_area.position = map_to_local(mouse_map_position)
	
	if place_timer <= 0:
		place_timer = place_time
		if Input.is_action_pressed("ui_accept"):
			var clicked_map_position = local_to_map(place_area.position)
			place_sceene(objects['imp'], clicked_map_position)
	else: place_timer -= delta
		



