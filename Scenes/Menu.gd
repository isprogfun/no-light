extends Control

func _on_start_button_pressed():
	Global.go_to_next_level()


func _on_quit_button_pressed():
	get_tree().quit()
