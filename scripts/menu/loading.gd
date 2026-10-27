extends Control

func _ready():
	$AnimatedSprite2D.play("default")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
