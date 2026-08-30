extends Node

@export var legit: bool = false
@export var username := "Carlinhos"
var content: String
var legit_dict: Dictionary[String, StringList]
var false_dict: Dictionary[String, StringList]

var dict: Dictionary[String, String] = {}

func _ready() -> void:
	
	legit_dict = initialize_dicts("res://Text/legit.txt")
	legit_dict.get_or_add("[Username]", StringList.new([username]))
	false_dict = initialize_dicts("res://Text/false.txt")
	
	generate_keywords()
	replace_keywords()
	print(content)

func initialize_dicts(path) -> Dictionary[String, StringList]:
	var tmp_dict: Dictionary[String, StringList] = {}
	tmp_dict["fulano"] = StringList.new([username])
	
	var file := FileAccess.open(path, FileAccess.READ)
	var fileString = file.get_as_text()
	fileString.remove_chars("\r")
	fileString = fileString.split("\n")
	fileString.remove_at(fileString.size() - 1)
	for line in fileString:
		line = line.split(",")
		var tmp_array = line.duplicate()
		tmp_array.remove_at(0)
		var tmp_string_data = StringList.new(tmp_array)
		tmp_dict.get_or_add(line[0], tmp_string_data)
	return tmp_dict

func generate_keywords() -> void:
	#dict.get_or_add("[fulano]", [username])
	if legit:
		for key in legit_dict:
			dict.get_or_add(key, legit_dict[key].list.pick_random())
	else:
		false_dict = get_shuffled_dict(false_dict)
		var rng_counter : float = 0
		for key in false_dict:
			if (randf_range(0.0, 1.0) + rng_counter > 1):
				dict.get_or_add(key, false_dict[key].list.pick_random())
			else:
				dict.get_or_add(key, legit_dict[key].list.pick_random())
			rng_counter += 1.0/false_dict.size()

func replace_keywords() -> void:
	var file := FileAccess.open("res://Text/Emails/teste.txt", FileAccess.READ)
	content = file.get_as_text()
	for keyword in dict:
		content = content.replace(keyword, dict[keyword])
	content = content.remove_chars("[]")

func get_shuffled_dict(original: Dictionary[String, StringList]) -> Dictionary[String, StringList]:
	var shuffled: Dictionary[String, StringList] = {}
	var keys = original.keys()
	keys.shuffle()
	for key in keys:
		shuffled[key] = original[key]
	return shuffled

#func parse(bgn_ptr) -> int:
	#bgn_ptr = content.find("[", bgn_ptr)
	#var end_ptr = content.find("]", bgn_ptr)
	#var content_type = content.substr(bgn_ptr + 1, end_ptr - bgn_ptr - 1)
	#var replace = dicti.get(content, "ERRO(dev)")
	#content = content.erase(bgn_ptr,  end_ptr - bgn_ptr - 1)
	#print(content_type)
	#print(bgn_ptr)
	#return content.find("[", end_ptr)
