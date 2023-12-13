extends Node
class_name GameData
const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "065fzef64dfs"

var player_data = PlayerData.new()
var player
func _ready():
	verify_save_directory(SAVE_DIR)
	player = get_tree().get_first_node_in_group("player") as Player

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func save_data(path: String):
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	var data = {
		"player_data": {
			"global_position":{
				"x": player_data.global_position.x,
				"y": player_data.global_position.y
			}
		}
	}
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()
	
func load_data(path:String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json string: (%s)" % [path, content])
			return
		
		player_data = PlayerData.new()
		player_data.global_position = Vector2(data.player_data.global_position.x, data.player_data.global_position.y)
		player.global_position = player_data.global_position
	else:
		printerr("Cannot open non-existent file at %s!" % [path])

func _on_save_btn_pressed():
	save_data(SAVE_DIR + SAVE_FILE_NAME)


func _on_load_btn_pressed():
	load_data(SAVE_DIR + SAVE_FILE_NAME)
