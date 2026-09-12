extends Panel

@onready var image: ColorRect = $Image
@onready var price_label: Label = $Price
@onready var buy_btn: Button = $Buy
@onready var not_enough_coins: Popup = %NotEnoughCoins

@export var color: Color
@export var price: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image.color = color
	price_label.text = str(price) + " Coins"
	buy_btn.pressed.connect(_on_buy_pressed)
	if (GlobalValues.get_purchased_colors() as Array[Color]).has(color):
		buy_btn.text = "Choose"
		price_label.text = "Owned"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buy_pressed():
	if (GlobalValues.get_purchased_colors() as Array[Color]).has(color):
		GlobalValues.set_player_color(color)
		LevelManager.start_from_level_one()
	else:
		if GlobalValues.get_coins() >= price:
			GlobalValues.set_coins(GlobalValues.get_coins() - price)
			GlobalValues.add_purchased_color(color)
			GlobalValues.set_player_color(color)
			GlobalValues.save_data(GlobalValues.get_coins(), GlobalValues.get_player_color(), GlobalValues.get_purchased_colors())
			LevelManager.start_from_level_one()
		else:
			not_enough_coins.popup()
