extends CanvasModulate

@export var gradient: GradientTexture1D
@export var INGAME_SPEED = 10.0
@export var INITIAL_HOUR = 0:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2*PI) / MINUTES_PER_DAY
var time: float = 0.0
var past_minute:float = -1.0
var player_in_building: bool =false

signal time_tick(day:int, hour:int, minute:int)

func _ready():
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR
	World.player_in_building.connect(_stop_day_light_cycle)

func _process(delta) -> void:
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(time - PI / 2) +1.0) /2.0
	if !player_in_building:
		self.color = gradient.gradient.sample(value)
	else:
		self.color = Color.BLACK
	_recalculate_time()

func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)

func _stop_day_light_cycle(is_player_in_building:bool)-> void:
	player_in_building = is_player_in_building
