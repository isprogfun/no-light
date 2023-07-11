extends Node

var number_of_levels = 0;
var current_level = 0;
var current_scene = null;
var number_of_lives = 3

# Signals
signal success

# Constants
const COLOR_LIGHT = Color(0.96078431606293, 0.93725490570068, 0.90588235855103);
const COLOR_DARK = Color(0.15,0.15,0.15,1.0);

signal failure

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	var levels = Array(DirAccess.get_files_at("res://Scenes/Levels"))

	number_of_levels = levels.size()
	current_scene = root.get_child(root.get_child_count() - 1)

# Scene management
func go_to_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func go_to_main():
	go_to_scene("res://Scenes/Menu.tscn")
	MusicController.get_node("Background").stop()
	number_of_lives = 3
	current_level = 0;
	
func go_to_next_level():
	current_level += 1
	
	if current_level == 1:
		MusicController.get_node("Background").play();
	
	if number_of_levels < current_level:
		emit_signal("success")
		
		return
	
	var current_level_path = "res://Scenes/Levels/Level_" + str(current_level) + ".tscn"
	
	go_to_scene(current_level_path)

func restart_level():
	go_to_scene("res://Scenes/Levels/Level_" + str(current_level) + ".tscn")
	
func on_fall():
	number_of_lives = number_of_lives - 1
	
	if number_of_lives > 0:
		restart_level()
	else:
		emit_signal("failure")

func _deferred_goto_scene(path):
	current_scene.free()
	
	# load the new scene
	var scene = ResourceLoader.load(path)
	
	# Instance the new scene
	current_scene = scene.instantiate()
	
	# Add to the current scene, as child of root
	get_tree().root.add_child(current_scene)
	
	get_tree().current_scene = current_scene
