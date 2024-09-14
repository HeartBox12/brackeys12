extends Control

signal start

func _on_start_pressed():
	start.emit()

func _on_vol_slider_changed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db($volSlider.value))
