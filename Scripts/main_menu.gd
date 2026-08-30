extends CanvasLayer


func _on_button_pressed() -> void:
	Globals.username = $CenterContainer/VBoxContainer/LineEdit.text
	get_tree().change_scene_to_file("uid://c58q7k2nwm30h")
