extends Node2D

const gap = 250
@onready var itemColumn = preload("res://Scenes/item_column.tscn")
const window_width = 1152
var number_of_columns = ceil(window_width/gap)+3

func _ready():
	
	for i in number_of_columns:
		var ItemColumn = itemColumn.instantiate()
		add_child(ItemColumn)
		ItemColumn.end_reached.connect(change_position)
		ItemColumn.position.x = number_of_columns*gap + i*gap


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_position(obj):
	obj.position.x = number_of_columns*gap - 100
