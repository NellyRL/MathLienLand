tool
extends RichTextEffect
class_name RichTextSup

# Syntax: [sup height=1.0][/sup]

# Define the tag name.
var bbcode = "sup"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var height = char_fx.env.get("height", 3.0)

	var y_off = 2 * height
	char_fx.offset = Vector2(0, -1) * y_off
	return true
