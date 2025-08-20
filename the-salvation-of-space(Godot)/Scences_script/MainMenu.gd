extends Control

func _ready():
	$StartButton.pressed.connect(_on_StartButton_pressed)
	$QuitButton.pressed.connect(_on_QuitButton_pressed)
	$SettingButton.pressed.connect(_on_SettingButton_pressed)

func _on_StartButton_pressed():
	var game_scene = load("res://game_tscn/chapter1/level_1/home.tscn") # 替换为游戏开始场景路径
	get_tree().change_scene_to_packed(game_scene)
	
func _on_SettingButton_pressed():
	var game_scene = load("res://Scences/setting.tscn")
	get_tree().change_scene_to_packed(game_scene)

func _on_QuitButton_pressed():
	get_tree().quit()
