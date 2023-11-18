extends Node2D

@export var initpos = -100
var score = 0
var grid_offset = 110
var pos = 2
var sprite_resources = ["res://Assets/giraffe_art/Giraffe_h4.png", "res://Assets/giraffe_art/Giraffe_h3.png", "res://Assets/giraffe_art/Giraffe_h2.png", "res://Assets/giraffe_art/Giraffe_h1.png"]
@onready var area = $Area2D
@onready var sprite = $Sprite2D
signal player_dead
var img = Image.new()
var tween


func _ready():
	$AnimationPlayer.current_animation = "shake"
	position.x = initpos
	tween = create_tween()
	tween.tween_property(self,"position",Vector2(250,0),4)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if event.position.y >= 648/2 and pos!=3:
			pos += 1
		elif event.position.y < 648/2 and pos!=0:
			pos -= 1


func _process(delta):
	if Input.is_action_just_pressed("ui_up") and pos != 0:
		pos -= 1
		
	elif Input.is_action_just_pressed("ui_down") and pos != 3:
		pos += 1
	
	area.position.y = grid_offset*(pos + 0.5)
	sprite.texture = load(sprite_resources[pos])
	$CanvasLayer/Panel/Label.text = str(score)


func _on_area_2d_area_entered(area):
	if(area.is_in_group("collectables")):
		area.queue_free()
		score += 1
		$BitePlayer.play()
	else:
		$PunchPlayer.play()
		$AnimationPlayer.stop()
		$AnimationPlayer.play("die")
		get_tree().paused = true



func _on_animation_player_animation_finished(anim_name):
	player_dead.emit(score)
	get_tree().paused = false
