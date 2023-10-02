extends Camera2D
	

func updateTileMapLimit(tileMap):
	var mapRect = tileMap.get_used_rect() #REnvoi un rectangle avec la position et la taille de la tilemap
	var tileSize = tileMap.cell_quadrant_size #Renvoi la taille d'une tile
	limit_left = mapRect.position.x * tileSize
	limit_right = limit_left + mapRect.size.x * tileSize
	limit_top = mapRect.position.y * tileSize
	limit_bottom = limit_top + mapRect.size.y * tileSize
	
#	print("left ", limit_left)
#	print("right ", limit_right)
#	print("top ", limit_top)
#	print("down ", limit_bottom)
#	print("map rect ", mapRect)
#	print(tileSize)
	

func updatePlayerPosition(spawn, body):
	body.position.x = spawn.global_position.x
	body.position.y = spawn.global_position.y
	

func _on_border_reached(tileMap, spawn, player):
	updateTileMapLimit(tileMap)
	updatePlayerPosition(spawn, player)


func _on_bank_enter_bank(player, spawn, interiorTileMap):
	updatePlayerPosition(spawn, player)
	updateTileMapLimit(interiorTileMap)
