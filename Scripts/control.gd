extends Panel

var dragging := false
var drag_offset := Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_offset = global_position - event.global_position
			else:
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		global_position = event.global_position + drag_offset
