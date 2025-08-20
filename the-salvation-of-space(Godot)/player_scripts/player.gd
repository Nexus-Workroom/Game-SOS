extends CharacterBody2D

var normal_speed: float = 600.0
var boost_speed: float = 800.0
var current_speed: float = 600.0
var is_boosting: bool = false
var last_direction: Vector2 = Vector2.DOWN  # 记录最后移动方向

@onready var animated_sprite = $AnimatedSprite2D
@export var animator :AnimatedSprite2D

func _ready():
	current_speed = normal_speed
	animated_sprite.play("down_idle")
	
func _physics_process(_delta):
	# 获取输入方向
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# 更新速度
	velocity = direction * current_speed
	
	# 执行移动
	if velocity.length() > 0:
		move_and_slide()
		last_direction = velocity.normalized()
	# 根据移动方向播放动画
	if velocity == Vector2.ZERO:
		# 播放对应方向的站立动画
		if abs(last_direction.x) > abs(last_direction.y):
			# 水平方向为主
			if last_direction.x > 0:
				animated_sprite.play("right_idle")
			else:
				animated_sprite.play("left_idle")
		else:
			# 垂直方向为主
			if last_direction.y > 0:
				animated_sprite.play("down_idle")
			else:
				animated_sprite.play("up_idle")
	else:
		# 播放移动动画
		if abs(velocity.x) > abs(velocity.y):
			# 水平移动
			if velocity.x > 0:
				animated_sprite.play("right_go")
			else:
				animated_sprite.play("left_go")
		else:
			# 垂直移动
			if velocity.y > 0:
				animated_sprite.play("down_go")
			else:
				animated_sprite.play("up_go")
# 方法1：使用 _input 事件处理
func _input(event):
	# 检测 SHIFT 键按下
	if event is InputEventKey:
		# 左SHIFT或右SHIFT
		if event.keycode == KEY_SHIFT:
			if event.pressed:
				# SHIFT 按下
				is_boosting = true
				current_speed = boost_speed
			else:
				# SHIFT 释放
				is_boosting = false
				current_speed = normal_speed
				animated_sprite.modulate = Color.WHITE

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://game_tscn/chapter1/level_2/dajie.tscn")
