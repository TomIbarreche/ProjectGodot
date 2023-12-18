extends Camera2D
	
func _ready():
	make_current()
	
func updateTileMapLimit(tileMap):
	var mapRect = tileMap.get_used_rect() #REnvoi un rectangle avec la position et la taille de la tilemap
	var tileSize = tileMap.cell_quadrant_size #Renvoi la taille d'une tile
	limit_left = mapRect.position.x * tileSize
	limit_right = limit_left + mapRect.size.x * tileSize
	limit_top = mapRect.position.y * tileSize
	limit_bottom = limit_top + mapRect.size.y * tileSize


func updatePlayerPosition(spawn, body):
	body.position.x = spawn.global_position.x
	body.position.y = spawn.global_position.y
	

func _on_border_reached(tileMap, spawn, player):
	updateTileMapLimit(tileMap)
	updatePlayerPosition(spawn, player)


func _on_bank_enter_bank(player, spawn, interiorTileMap):
	updatePlayerPosition(spawn, player)
	update_tilemap_limit_for_building(interiorTileMap)
	World.is_player_in_building = true
	
func update_tilemap_limit_for_building(interiorTileMap):
	var mapRect = interiorTileMap.get_used_rect() #REnvoi un rectangle avec la position et la taille de la tilemap
	var tileSize = interiorTileMap.cell_quadrant_size
	limit_left = interiorTileMap.global_position.x
	limit_right = limit_left + mapRect.size.x *tileSize
	limit_top = interiorTileMap.global_position.y
	limit_bottom = limit_top + mapRect.size.y * tileSize


func _on_bank_interior_exit_bank(player, spawn, exteriorTileMap):
	updatePlayerPosition(spawn, player)
	updateTileMapLimit(exteriorTileMap)
	World.is_player_in_building = false	
	
