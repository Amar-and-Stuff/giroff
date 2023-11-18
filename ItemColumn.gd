extends Node2D

var state = [0,0,0,0]
const resources = ["res://Scenes/rock.tscn", "", "res://Scenes/berry.tscn", "res://Scenes/carrot.tscn", "res://Scenes/Apple.tscn"]
const grid_offset = 110
var items = [null, null, null, null]
signal end_reached

# Level1 vars
var speed = 200
var collectable_list = [1,2,3]
var position_of_collectable = [0,1,2,3]
var number_of_obstacles_list = [0,0,0,0,0,1,1,1,1,1,2,2,2,3]
# Level2 vars
var number_of_obstacles2 = [0,0,1,1,1,2,2,2,2,2,3,3,3,3,3]
'''
-1 - obstacle/rock
0 - nothing
1 - berries
2 - carrot
3 - apple
'''
func _ready():
	update_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x -= speed * delta
	
	if global_position.x <= -100:
		update_state()
		end_reached.emit(self)
	# print(get_reasonable_state())


func update_state():
	for i in 4:
		if state[i] != 0 and items[i]:
			items[i].queue_free()
	
	state = get_reasonable_state()
	for i in 4:
		if state[i] == 0:
			continue
		var temp = load(resources[state[i]+1]).instantiate()
		add_child(temp)
		temp.global_position.y = grid_offset*(i+0.5)
		items[i] = temp


func get_reasonable_state():
	var new_state = [0,0,0,0]
	var positions = [0,1,2,3]
	var collectable_position = randi_range(0,3)
	new_state[collectable_position] = randi_range(1,3)
	positions.erase(collectable_position)
	var number_of_obstacles = number_of_obstacles_list[randi_range(0,len(number_of_obstacles_list)-1)]
	for i in number_of_obstacles:
		var ob_pos = randi_range(0,len(positions)-1)
		new_state[positions[ob_pos]] = -1
		positions.erase(ob_pos)
	return new_state
