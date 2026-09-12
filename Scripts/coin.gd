extends Area3D

var coins: int = GlobalValues.get_coins()

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		coins += 1
		GlobalValues.set_coins(GlobalValues.coins + 1)
		print(GlobalValues.coins)
		queue_free()
