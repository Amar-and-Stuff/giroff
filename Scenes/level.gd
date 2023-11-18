extends Node2D
signal game_over



func _on_player_player_dead(score):
	game_over.emit(score)


