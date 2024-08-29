extends CharacterBody2D

@export var move_speed: float = 100.0
@export var waypoints: Array = [Vector2(100, 100), Vector2(300, 100), Vector2(300, 300), Vector2(100, 300)]
var current_waypoint_index: int = 0
var navigation_agent: NavigationAgent2D

func _ready():
	# Crear y configurar el agente de navegación
	navigation_agent = NavigationAgent2D.new()
	add_child(navigation_agent)
	# Asignar el primer destino
	set_next_target()

func _process(delta):
	if navigation_agent.is_navigation_finished():
		set_next_target()
		return

	# Obtener la siguiente posición en la ruta
	var path_position = navigation_agent.get_next_path_position()
	if path_position != null:
		var direction = (path_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()

func set_next_target():
	# Asignar la siguiente posición destino
	navigation_agent.target_position = waypoints[current_waypoint_index]
	current_waypoint_index = (current_waypoint_index + 1) % waypoints.size()
