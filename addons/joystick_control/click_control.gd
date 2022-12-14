tool
extends Control

signal clicked(value)


var can_click := true
var touch_idx := -1


func _init():
	if not Engine.editor_hint:
		connect("gui_input", self, "_gui_input")


func _input(event: InputEvent):
	if event is InputEventScreenTouch and not event.is_pressed() and touch_idx == event.index:
		touch_idx = -1
		emit_signal("clicked", false)
		get_tree().set_input_as_handled()


func _gui_input(event : InputEvent):
	if can_click and event is InputEventScreenTouch and event.is_pressed() and touch_idx == -1:
		touch_idx = event.index
		emit_signal("clicked", true)
		accept_event()


