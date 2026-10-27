# Covers the time part, spawning, etc.
class_name Game extends Node2D

@onready var total_waves = Globals.waves
@onready var timer = Globals.timer
@onready var current_wave = 1
@onready var num_of_enemies = 0
var dead_enemies = 0
var can_spawn = false
var label

@onready var enemy_path = preload("res://scenes/actors/enemyBasic.tscn")
@onready var boss_path = preload("res://scenes/actors/enemyBoss.tscn")
@onready var hud_path = preload("res://scenes/hud.tscn")

func _ready() -> void:
	$gameTimer.wait_time = 150.0
	$gameTimer.start()
	timer = $gameTimer.time_left
	$AnimatedSprite2D.play("default")
	Globals.game_state = true
	var hud = hud_path.instantiate()
	hud.gameInstance = self
	add_child.call_deferred(hud)
	label = true

# Waves info:
# W1 - 3 enemies
# W2 - 4 enemies
# W3 - 5 enemies
# W4 - Boss
# W5 - Boss, 3 enemies

func _on_wave_timer_timeout() -> void:
	can_spawn = true
	label = false
	
func _on_game_timer_timeout() -> void:
	Globals.game_state = false
	get_tree().change_scene_to_file("res://scenes/endings/lose.tscn")

func _process(_delta):
	if can_spawn:
		wave_handler(current_wave)
	if Globals.game_state:
		timer = $gameTimer.time_left
	#print(timer)
	
	if Globals.p_health <= 0:
		Globals.game_state = false
		$gameTimer.stop()
		get_tree().change_scene_to_file("res://scenes/endings/lose.tscn")
		
	
func wave_handler(wave):
	match wave:
		1:
			match num_of_enemies:
				0:
					num_of_enemies = 3
					spawn_enemy(num_of_enemies)
					$gameTimer.start(timer)
				dead_enemies:
					current_wave += 1
					dead_enemies = 0
					num_of_enemies = 0
					print("wave completed.")
					$waveTimer.start(3.0)
					can_spawn = false
					label = true
		2:
			match num_of_enemies:
				0:
					num_of_enemies = 4
					spawn_enemy(num_of_enemies)
				dead_enemies:
					current_wave += 1
					dead_enemies = 0
					num_of_enemies = 0
					$waveTimer.start(3.0)
					can_spawn = false
					label = true
		3:
			match num_of_enemies:
				0:
					num_of_enemies = 5
					spawn_enemy(num_of_enemies)
				dead_enemies:
					current_wave += 1
					dead_enemies = 0
					num_of_enemies = 0
					$waveTimer.start(3.0)
					can_spawn = false
					label = true
		4:
			match num_of_enemies:
				0:
					spawn_boss()
					num_of_enemies = 1
				dead_enemies:
					current_wave += 1
					dead_enemies = 0
					num_of_enemies = 0
					$waveTimer.start(3.0)
					can_spawn = false
					label = true
		5:
			#winning conditions
			match num_of_enemies:
				0:
					num_of_enemies = 7
					spawn_boss()
					spawn_enemy(num_of_enemies - 1)
				dead_enemies:
					#winning conditions
					Globals.game_state = false
					$gameTimer.stop()
					get_tree().change_scene_to_file("res://scenes/endings/win.tscn")

func spawn_enemy(noe):
	if can_spawn: 
		for en in noe:
			var pos_x = randi_range(100, 1600)
			var pos_y = randi_range(100, 600)
			var enemy = enemy_path.instantiate()
			enemy.pos = Vector2(pos_x, pos_y)
			enemy.add_to_group("Enemy")
			enemy.game_logic = self
			get_parent().add_child(enemy)
			#print("Enemy at: (", pos_x, ", ", pos_y, ")")

func spawn_boss():
	if can_spawn:
		var boss = boss_path.instantiate()
		boss.pos = Vector2(965, 350)
		boss.add_to_group("Enemy")
		boss.game_logic = self
		get_parent().add_child(boss)
		

func enemy_dead():
	dead_enemies += 1
