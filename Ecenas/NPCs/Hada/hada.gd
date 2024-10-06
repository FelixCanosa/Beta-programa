extends CharacterBody2D

var player_in_range = false
var dialog_active = false

# Referencia a la caja de diálogo (inicialmente nula)
var dialog_box = null

# Referencia al jugador
@onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
		$InteractionIndicator.hide()

func _process(delta):
		if dialog_active:
				update_dialog_position()

func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
				player_in_range = true
				$InteractionIndicator.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
				player_in_range = false
				$InteractionIndicator.hide()

func _input(event):
		if event.is_action_pressed("interact") and player_in_range and not dialog_active:
				start_dialog()
		elif event.is_action_pressed("ui_cancel") and dialog_active:
				end_dialog()

func start_dialog():
		dialog_active = true
		$InteractionIndicator.hide()

		# Cargar la escena del diálogo solo si aún no ha sido cargada
		if dialog_box == null:
				dialog_box = load("res://ModelosAIs/logica_HADA_AI/modelo.tscn").instantiate()
				get_tree().root.add_child(dialog_box)
				dialog_box.hide()

		if dialog_box:
				update_dialog_position()
				dialog_box.show()
		else:
				print("Error: No se encontró la caja de diálogo")

		disable_player_movement()

func end_dialog():
		dialog_active = false
		if dialog_box:
				dialog_box.hide()
		$InteractionIndicator.show()
		enable_player_movement()

func update_dialog_position():
		if player and dialog_box:
				# Posicionar la caja de diálogo encima del jugador
				dialog_box.global_position = player.global_position + Vector2(-250, -150)

func disable_player_movement():
		if player.has_method("disable_movement"):
				player.disable_movement()

func enable_player_movement():
		if player.has_method("enable_movement"):
				player.enable_movement()
