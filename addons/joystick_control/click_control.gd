tool
extends Control

signal clicked(value)


var touch_idx := -1


func _init():
	if not Engine.editor_hint:
		connect("gui_input", self, "_gui_input")


func _input(event):
	if event is InputEventScreenTouch and not event.is_pressed() and touch_idx == event.index:
		touch_idx = -1
		emit_signal("clicked", false)


func _gui_input(event : InputEvent):
	if event is InputEventScreenTouch and event.is_pressed():
		touch_idx = event.index
		emit_signal("clicked", true)

