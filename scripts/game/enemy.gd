class_name BasicEnemy extends CharacterBody2D

@onready var health = Globals.eBasic_health # max health
@onready var attack_speed = Globals.eBasic_attack_speed
@onready var bullet_path = preload("res://scenes/actors/bullet.tscn")

@onready var player_damage = Globals.p_attack_damage
@onready var player = get_tree().get_first_node_in_group("player")
@onready var shoot_timer = $Timer
@onready var can_fire = true

var game_logic

var pos:Vector2

func _ready():
	global_position = pos
	$AnimatedSprite2D.play("default")

func _process(_delta):
	if shoot_timer.is_stopped() && Globals.game_state:
		look_at(player.global_position)
		fire_continuously()
	elif !Globals.game_state:
		queue_free()

func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = rotation
	bullet.pos = $Node2D.global_position
	#bullet.rota = player.global_position
	bullet.speedX = 500
	bullet.speedY = 0
	bullet.label = "enemyBasic"
	get_parent().add_child(bullet)
	can_fire = false

func fire_continuously():
	if can_fire:
		fire()
		await get_tree().create_timer(attack_speed).timeout
		can_fire = true
		fire_continuously()
		
func get_hit():
	if (health - player_damage) <= 0:
		#game over
		queue_free()
		game_logic.enemy_dead()
	else:
		health -= player_damage
