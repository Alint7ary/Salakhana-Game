extends Node2D
var score = 0


#func _ready():
	#$"../CharacterBody2D".glide_bar = $"../HUD/GlideBar"

func add_point():
	score += 1
	print(score)
