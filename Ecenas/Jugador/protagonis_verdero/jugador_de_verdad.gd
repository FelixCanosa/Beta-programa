extends CharacterBody2D

var animation_tree
var animationa_playback
var can_move = true

func _ready():
	animation_tree = get_node("Sprite2D/AnimationTree")
	animationa_playback = animation_tree.get("parameters/playback")

func _physics_process(_delta):
	if can_move:
		var move_direction = Vector2(
			Input.get_action_strength("drecha") - Input.get_action_strength("izquierda"),
			Input.get_action_strength("abajo") - Input.get_action_strength("arriba")
		)
		var velocidad = 150
		velocity = move_direction.normalized() * velocidad
		move_and_slide()
		update_animations(move_direction)
	else:
		# Si no puede moverse, asegurarse de que la velocidad sea cero
		velocity = Vector2.ZERO
		update_animations(Vector2.ZERO)

func update_animations(move_direction):
	if (move_direction != Vector2.ZERO):
		animationa_playback.travel("caminar")
		animation_tree.set("parameters/caminar/blend_position", move_direction)
		animation_tree.set("parameters/Reposo/blend_position", move_direction)
	else:
		animationa_playback.travel("Reposo")

func disable_movement():
	can_move = false

func enable_movement():
	can_move = true
