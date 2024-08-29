extends CharacterBody2D

@export var speed = 200.0
@export var points: Array[Vector2] = []

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_point_index = 0
var threshold_distance = 10.0  # Distancia para considerar que ha llegado al punto
var last_direction = Vector2.ZERO

func _ready():
	# Esperar a que el árbol de escena esté listo
	await get_tree().process_frame
	
	if not points.is_empty():
		set_movement_target(points[0])

func _physics_process(delta):
	if nav_agent.is_navigation_finished() or global_position.distance_to(nav_agent.target_position) < threshold_distance:
		# Pasar al siguiente punto
		current_point_index = (current_point_index + 1) % points.size()
		set_movement_target(points[current_point_index])
	
	# Calcular la dirección hacia el siguiente punto en la ruta
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_position)
	
	# Actualizar last_direction solo si estamos en movimiento
	if direction.length() > 0.1:
		last_direction = direction
	
	# Calcular y aplicar la velocidad
	velocity = direction * speed
	move_and_slide()
	
	# Actualizar la animación basada en la dirección
	update_animation(last_direction)

func set_movement_target(target: Vector2):
	nav_agent.target_position = target

func update_animation(direction: Vector2):
	if direction.length() < 0.1:
		animated_sprite.play("idle")
	elif abs(direction.x) > abs(direction.y):
		# Movimiento horizontal
		animated_sprite.play("right")
		# Voltear el sprite si es necesario
		animated_sprite.flip_h = direction.x < 0
	else:
		# Movimiento vertical
		animated_sprite.play("down" if direction.y > 0 else "up")
		# Mantener la orientación horizontal previa
		animated_sprite.flip_h = last_direction.x < 0
