extends Node

# Based on difficulty (if I have the time)
# Easy: default
# Hard: default + additional Wave

# Game progression
var waves = 5
var timer = 150 # set 60s for a minute -> 2:30
var game_state:bool

# Player (can be overwritten)
var p_move_speed = 400 # movement speed
var p_health:int
var p_attack_speed = 1000 # ms between attacks when holding attack button
var p_attack_damage = 15 # 10 damage per hit

# Enemy - Basic
var eBasic_health = 60 # health of a basic enemy
var eBasic_attack_speed = 1.5 # ms between attacks
var eBasic_attack_damage = 5 # damage on hit

# Enemy - Boss
var eBoss_health = 250
var eBoss_attack_speed = 1.0 # ms of attacks
var eBoss_attack_damage = 25 # damage on hit
