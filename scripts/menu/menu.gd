extends Node

func _ready():
	$AnimatedSprite2D.play("default")

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/loading.tscn")


func _on_quit_button_down() -> void:
	get_tree().quit()
