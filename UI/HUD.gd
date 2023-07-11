extends CanvasLayer

var level_label
var container
var text_label
var health_bar
var heart

# Called when the node enters the scene tree for the first time.
func _ready():
	level_label = get_node("LevelLabel")
	container = get_node("Container")
	text_label = container.get_node("Label")
	health_bar = get_node("HealthBar")
	heart = health_bar.get_node("Heart")

	container.hide()

	level_label.text = "Level: " + str(Global.current_level) + "/" + str(Global.number_of_levels)
	
	_show_lives()

	Global.connect("success", _on_success)
	Global.connect("failure", _on_failure)

func _show_lives():
	for i in range(Global.number_of_lives):
		var newHeart = heart.duplicate()
		newHeart.show()
		health_bar.add_child(newHeart)

func set_mode(mode):
	if mode == "entered":
		level_label.set("theme_override_colors/font_color", Global.COLOR_DARK)
	elif mode == "exited":
		level_label.set("theme_override_colors/font_color", Global.COLOR_LIGHT)

func _on_success():
	get_tree().paused = true
	text_label.text = "Congratulations! You've passed all the tests!"
	container.show()

func _on_failure():
	get_tree().paused = true
	text_label.text = "Oh no! You've failed to pass the tests!"
	container.show()

func _on_main_button_pressed():
	get_tree().paused = false
	Global.go_to_main()

func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().quit()
