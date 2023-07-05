extends Node2D

var player
var starting_area
var exit
var holes
var tile_map
var background
var hud

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player")
	starting_area = get_node("Level/StartingArea")
	exit = get_node("Level/Exit");
	tile_map = get_node("Level/TileMap")
	background = get_node("Level/Background")
	hud = get_node("HUD");
	holes = get_node_or_null('Level/Holes')

	starting_area.body_entered.connect(self._on_starting_area_body_entered)
	starting_area.body_exited.connect(self._on_starting_area_body_exited)
	
	exit.body_entered.connect(self._on_exit_body_entered)

	if holes:
		for hole in holes.get_children():
			hole.body_entered.connect(self._on_hole_body_entered)

func _on_starting_area_body_entered(_body):
	tile_map.show()
	background.color = Global.COLOR_LIGHT
	hud.set_mode("entered")

func _on_starting_area_body_exited(_body):
	tile_map.hide()
	background.color = Global.COLOR_DARK
	hud.set_mode("exited")

func _on_exit_body_entered(_body):
	Global.go_to_next_level();

func _on_hole_body_entered(_body):
	Global.on_fall()
