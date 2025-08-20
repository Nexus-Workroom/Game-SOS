extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$BackButton.pressed.connect(_on_BackButton_pressed)

func _on_BackButton_pressed():
	var game_scene = load("res://Scences/main_menu.tscn") # 替换为游戏开始场景路径
	get_tree().change_scene_to_packed(game_scene)
