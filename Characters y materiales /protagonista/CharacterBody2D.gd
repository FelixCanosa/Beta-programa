extends CharacterBody2D


var animation_tree
var animationa_playback



func _ready():
	animation_tree = get_node("Sprite2D/AnimationTree")
	animationa_playback = animation_tree.get("parameters/playback")
	
#	$Modelo.visible = false

	
func _process(delta):
	# Comprueba si el jugador ha presionado la tecla "R"
	if Input.is_action_just_pressed("AprecerAcistente"):
		# Cambia la visibilidad de la interfaz
		$Modelo.visible = !$Modelo.visible

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
		


