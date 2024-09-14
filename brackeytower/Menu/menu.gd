extends Control

signal start

func _ready():
	$volSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))

func _on_start_game():
	start.emit()

func _on_vol_slider_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
