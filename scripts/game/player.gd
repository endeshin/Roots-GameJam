# Covers the player movement, attack & health
class_name Player extends CharacterBody2D
var bullet_path = preload("res://scenes/actors/bullet.tscn")

# Init definitions
@onready var health = Globals.p_health # max health
@onready var move_speed = Globals.p_move_speed
@onready var move_speed_slow = Globals.p_move_speed / 2
@onready var attack_speed = Globals.p_attack_speed # once per .5 sec

# Enemy damage
@onready var enemy_damage = Globals.eBasic_attack_damage
@onready var boss_damage = Globals.eBoss_attack_damage

# states check
@onready var can_fire = true
@onready var fire_continuous = false

func _ready():
	$AnimatedSprite2D.play("default")
	if health != 100:
		Globals.p_health = 100
		health = Globals.p_health

# movement
func get_input(): 
	var input_direction = Input.get_vector("left", "right", "up", "down")
	# slow down player when prompted
	if Input.is_action_pressed("slow"):
		velocity = input_direction * move_speed_slow
	else:
		velocity = input_direction * move_speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		fire()
	if Input.is_action_just_pressed("shoot_infinite"):
		if fire_continuous:
			fire_continuous = false
		else:
			fire_continuous = true
			fire_bullet_multiple()
	
# Firing functions
func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = rotation
	bullet.pos = $Node2D.global_position
	#bullet.rota = global_rotation
	bullet.speedX = 1000
	bullet.speedY = 0
	bullet.label = "player"
	get_parent().add_child(bullet)
	if fire_continuous:
		can_fire = false

func fire_bullet_multiple():
	if can_fire:
		fire()
		await get_tree().create_timer(attack_speed / 1000).timeout
		can_fire = true
		if fire_continuous:
			fire_bullet_multiple()
			
# Hit functions
func got_hit(label):
	var damage = 0
	# assign correct damage value
	match label:
		"enemyBasic":
			damage = enemy_damage
		"enemyBoss":
			damage = boss_damage
			
	# take the damage
	health -= damage
	Globals.p_health = health

	
