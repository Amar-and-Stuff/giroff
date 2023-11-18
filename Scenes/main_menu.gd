extends CanvasLayer

signal start_pressed


func _ready():
	$AnimationPlayer.play("height_change")


func _on_play_button_pressed():
	start_pressed.emit()



func _on_credit_close_pressed():
	$CreditsPanel.visible = false


func _on_social_close_pressed():
	$SocialPanel.visible = false


func _on_credits_button_pressed():
	$CreditsPanel.visible = true


func _on_social_button_pressed():
	$SocialPanel.visible = true
