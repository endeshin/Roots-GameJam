extends CharacterBody2D

var pos:Vector2
var dir:float
var speedX:int
var speedY:int
var label:String


func _ready():
	global_position=pos
	rotation=dir
	$AnimatedSprite2D.play("default")
	
func _physics_process(delta):
	velocity = Vector2(speedX, speedY).rotated(dir)
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		#print(collider.name)
		# match the damage for each
		match collider.name:
			"Player":
				#print("player got hit.")
				collider.got_hit(label)
				destroy_bullet()
			_:
				if collider.is_in_group("Enemy") && label == "player":
					collider.get_hit()
					destroy_bullet()
				else:
					destroy_bullet()

func destroy_bullet():
	queue_free()
