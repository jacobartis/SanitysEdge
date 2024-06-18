extends Node

var enemies = {}

func _ready():
	load_enemies()

func load_enemies():
	var dir = "res://enemies/enemy_scenes/"
	var dir_access = DirAccess.open(dir)
	print("Loading enemies")
	if dir_access:
		print("Dir open")
		dir_access.list_dir_begin()
		var file_name = "is overwritten"
		while file_name != "":
			print("file found ",file_name)
			file_name = dir_access.get_next().trim_suffix('.remap')
			if !".tscn" in file_name:
				print(file_name," is not valid to load")
				continue
			print(file_name," is valid to load, trying to load")
			var enemy = ResourceLoader.load(dir+file_name,"Resource")
			var enemy_instance = enemy.instantiate()
			enemies[enemy_instance.id] = enemy
			print("Loaded and added ",enemy_instance.id)
	print(enemies)
