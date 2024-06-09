extends CharacterBody2D


var animation_tree
var animationa_playback

func _ready():
	$Sprite2D/AnimationTree.speed_scale=2.0
	animation_tree = get_node("Sprite2D/AnimationTree")
	animationa_playback = animation_tree.get("parameters/playback")

func _physics_process(delta):
	var move_direciton = Vector2(
		Input.get_action_strength("drecha") - Input.get_action_strength("izquierda"),
		Input.get_action_strength("abajo") - Input.get_action_strength("arriba"),
	)
	var velocidad = 200
	velocity = move_direciton.normalized() * velocidad
	move_and_slide()
	update_animations(move_direciton)

func update_animations(move_direciton):
	if (move_direciton != Vector2.ZERO):
		animationa_playback.travel("idle") #caminar
		animation_tree.set("parameters/idle/blend_position", move_direciton)
		animation_tree.set("parameters/descansar/blend_position", move_direciton)
	else:
		animationa_playback.travel("descansar") 
		


