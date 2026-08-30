extends Panel

var dragging := false
var drag_offset := Vector2.ZERO
var initial_position = global_position
var open := false

@onready var window := get_parent()


func _ready() -> void:
	window.hide()
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_offset = window.global_position - event.global_position
			else:
				dragging = false

	elif event is InputEventMouseMotion and dragging:
		var new_position = event.global_position + drag_offset

		var screen_size = get_viewport_rect().size
		var window_size = window.size


		new_position.x = clamp(
			new_position.x,
			0.0,
			screen_size.x - window_size.x
		)


		new_position.y = clamp(
			new_position.y,
			0.0,
			screen_size.y - window_size.y
		)

		window.global_position = new_position


func _on_button_pressed() -> void:
	window.global_position = initial_position
	window.hide()
	open = false


func _on_button_2_pressed() -> void:
	window.hide()
	open = false


func _on_bar_button_pressed() -> void:
	if open:
		window.hide()
		open = false
	elif not open:
		window.show()
		open = true
