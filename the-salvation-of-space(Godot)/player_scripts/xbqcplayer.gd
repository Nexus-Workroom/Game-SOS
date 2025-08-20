extends CharacterBody2D

# 移动参数 - 确保所有速度值都是浮点数（带小数点）
var normal_speed: float = 200.0      # 正常移动速度
var boost_speed: float = 400.0       # 加速时的速度
var current_speed: float = 200.0     # 当前实际速度
var is_boosting = false              # 是否正在加速
var boost_cooldown: float = 0.0      # 加速冷却时间
var boost_duration: float = 0.0      # 当前加速持续时间

# 加速相关参数 - 确保所有值都是浮点数
const MAX_BOOST_DURATION: float = 2.0  # 最大加速持续时间
const BOOST_COOLDOWN_TIME: float = 1.0 # 冷却时间
const BOOST_DECAY_RATE: float = 0.05   # 速度衰减速率

# 节点引用
@onready var animated_sprite = $AnimatedSprite2D
#@onready var boost_particles = $BoostParticles  # 加速粒子效果（可选）
#@onready var boost_bar = $BoostBar  # 加速能量条（可选）

func _ready():
	# 初始化速度
	current_speed = normal_speed
	
	# 如果添加了加速条，初始化它
#    if boost_bar:
#        boost_bar.max_value = MAX_BOOST_DURATION
#        boost_bar.value = MAX_BOOST_DURATION

func _physics_process(delta):
	# 处理加速逻辑
	handle_boost(delta)
	
	# 获取输入方向
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# 更新速度
	velocity = direction * current_speed
	
	# 执行移动
	move_and_slide()

# 处理加速逻辑
func handle_boost(delta: float): 
	# 检测 SHIFT 键按下
	if Input.is_action_pressed("boost") and boost_duration > 0:
		is_boosting = true
		boost_cooldown = BOOST_COOLDOWN_TIME
		boost_duration = max(0.0, boost_duration - delta)
		
		# 应用加速效果（平滑过渡）
		current_speed = lerp(current_speed, boost_speed, 0.2)
		
		# 显示粒子效果
#        if boost_particles:
#            boost_particles.emitting = true
			# 根据移动方向旋转粒子
#            if velocity.length() > 0:
#                boost_particles.rotation = velocity.angle() + PI
	else:
		# 松开SHIFT时恢复普通速度
		is_boosting = false
		current_speed = lerp(current_speed, normal_speed, 0.2)
		
		# 停止粒子效果
#        if boost_particles:
#            boost_particles.emitting = false
		
		# 恢复加速能量
#        if boost_duration < MAX_BOOST_DURATION and boost_cooldown <= 0:
#            boost_duration = min(MAX_BOOST_DURATION, boost_duration + delta * 0.5)
	
	# 更新冷却时间
#    boost_cooldown = max(0, boost_cooldown - delta)
	
	# 更新UI显示
#    if boost_bar:
#        boost_bar.value = boost_duration
