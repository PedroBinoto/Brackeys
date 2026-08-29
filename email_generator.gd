extends Node

@export var username := "Carlinhos"
var content: String
@onready var dict: Dictionary[String, String] = {"[fulano]": username}

func _ready() -> void:
	var file := FileAccess.open("res://Emails/teste.txt", FileAccess.READ)
	content = file.get_as_text()
	for keyword in dict:
		content = content.replace(keyword, dict[keyword])
	content = content.remove_chars("[]")
	
	var bgn_ptr = 0
	#while(bgn_ptr != -1):
		#bgn_ptr = parse(bgn_ptr)
		
	print(content)
	print(typeof(content))
	

#func parse(bgn_ptr) -> int:
	#bgn_ptr = content.find("[", bgn_ptr)
	#var end_ptr = content.find("]", bgn_ptr)
	#var content_type = content.substr(bgn_ptr + 1, end_ptr - bgn_ptr - 1)
	#var replace = dicti.get(content, "ERRO(dev)")
	#content = content.erase(bgn_ptr,  end_ptr - bgn_ptr - 1)
	#print(content_type)
	#print(bgn_ptr)
	#return content.find("[", end_ptr)
