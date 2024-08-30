extends Control




func _on_iniciobtn_pressed() -> void:
	get_tree().change_scene_to_file("res://mundos/mundo_1_1.tscn")

func _on_settingbtn_pressed() -> void:
	pass # Replace with function body.


func _on_exitbtn_pressed() -> void:
	get_tree().quit()
