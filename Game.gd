extends Node2D

@onready var mainMenu = preload("res://Scenes/main_menu.tscn")
@onready var endScreen = preload("res://Scenes/end_screen.tscn")
@onready var level = preload("res://Scenes/level.tscn")
var scene = null
func _ready():
	$BackgroundPlayer.play()
	load_main_menu()


func load_main_menu():
	clear_scene()
	scene = mainMenu.instantiate()
	add_child(scene)
	scene.process_mode = Node.PROCESS_MODE_PAUSABLE
	scene.start_pressed.connect(load_level)


func load_level():
	clear_scene()
	scene = level.instantiate()
	add_child(scene)
	scene.process_mode = Node.PROCESS_MODE_PAUSABLE
	scene.game_over.connect(load_end_screen)


func load_end_screen(score):
	clear_scene()
	scene = endScreen.instantiate()
	add_child(scene)
	scene.process_mode = Node.PROCESS_MODE_PAUSABLE
	scene.set_score(score)
	scene.restart_clicked.connect(load_level)
	scene.main_menu_clicked.connect(load_main_menu)

func clear_scene():
	if scene:
		scene.queue_free()


func _on_background_player_finished():
	$BackgroundPlayer.play()
