class_name enemyBoss extends CharacterBody2D

@onready var health = Globals.eBoss_health # max health
@onready var attack_speed = Globals.eBoss_attack_speed
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

func fire(x, y, rot, space:Vector2):
	var bullet = bullet_path.instantiate()
	bullet.dir = rot
	bullet.pos = $Node2D.global_position + space
	#bullet.rota = player.global_position
	bullet.speedX = x
	bullet.speedY = y
	bullet.label = "enemyBoss"
	get_parent().add_child(bullet)

func fire_continuously():
	if can_fire:
		fire(500, 0, (rotation - 0.78), Vector2(55,0))
		fire(500, 0, (rotation + 0.78), Vector2(-55,0))
		fire(500, 0, rotation, Vector2.ZERO)
		can_fire = false
		await get_tree().create_timer(attack_speed).timeout
		can_fire = true
		fire_continuously()
		
func get_hit():
	if (health - player_damage) <= 0:
		queue_free()
		game_logic.enemy_dead()
	else:
		health -= player_damage
