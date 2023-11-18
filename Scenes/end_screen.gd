extends CanvasLayer
signal restart_clicked
signal main_menu_clicked



func _on_replay_button_pressed():
	restart_clicked.emit()


func _on_main_menu_button_pressed():
	main_menu_clicked.emit()

func set_score(score):
	$Label.text = "Score : " + str(score)
