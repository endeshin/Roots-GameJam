extends Control

func resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _process(_delta):
	if Input.is_action_just_pressed("pause") && !get_tree().paused:
		pause()
		$AnimationPlayer.play("on_screen")
	elif Input.is_action_just_pressed("pause") && get_tree().paused:
		$AnimationPlayer.play_backwards("on_screen")
		resume()


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_resume_pressed() -> void:
	resume()
