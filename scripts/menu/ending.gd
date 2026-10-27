extends Control

func _ready():
	$AnimatedSprite2D.play("default")

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/loading.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
