extends Node2D

var file_path = "user://save_test.sav"

var value1 = 0
var value2 = 0
var value3 = 0

@onready var label_A = $Node/A
@onready var label_B = $Node/B
@onready var label_C = $Node/C

func Aplus():
	value1 += 1
	refresh()

func Bplus():
	value2 += 1
	refresh()

func Cplus():
	value3 += 1
	refresh()

func Aminus():
	value1 -= 1
	refresh()

func Bminus():
	value2 -= 1
	refresh()

func Cminus():
	value3 -= 1
	refresh()

func refresh():
	label_A.text = str(value1)
	label_B.text = str(value2)
	label_C.text = str(value3)

# Save all variables at once
func _saved():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var data = {
		"value1": value1,
		"value2": value2,
		"value3": value3
	}
	file.store_var(data)
	file.close()

# Save only value1, but keep value2 and value3 intact
func _saveA():
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	var data = {}
	if file.get_length() > 0:  # Check if the file has data
		data = file.get_var()
	data["value1"] = value1
	file.seek(0)  # Go to the start of the file to overwrite
	file.store_var(data)
	file.close()

# Save only value2
func _saveB():
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	var data = {}
	if file.get_length() > 0:
		data = file.get_var()
	data["value2"] = value2
	file.seek(0)
	file.store_var(data)
	file.close()

# Save only value3
func _saveC():
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	var data = {}
	if file.get_length() > 0:
		data = file.get_var()
	data["value3"] = value3
	file.seek(0)
	file.store_var(data)
	file.close()

# Load all variables
func _load():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var data = file.get_var()
		value1 = data.get("value1", 0)
		value2 = data.get("value2", 0)
		value3 = data.get("value3", 0)
		file.close()
	else:
		print("File does not exist")

	refresh()
