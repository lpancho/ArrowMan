extends Node

# Generate random enemy in certiain range of position
# container			= The node where the enemies will be generated
# enemyScene 		= Enemy to be replicated in the game
# groupName			= Group where the enemy should be added
# count				= Number of enemy to be replicated
# minX and maxX 	= Horizontal range where the enemy to place
# minY and maxY 	= Vertial range where the enemy to place
# direction 		= Where should the enemy be going (upwards = 1, downwards = -1, random = 0)
# has_bounds		= Set if the enemy will bounce back of the screen or will show in the opposite side
func GenerateRandomPositionEnemy(container, enemyScene, groupName, count, minX, maxX, minY, maxY, direction, has_bounds):
	randomize()
	
	for i in range(count):
		var enemy = enemyScene.instance()
		enemy.add_to_group(groupName)
		enemy.speed = enemy.speed * GetDirectionValue(direction)
		enemy.has_bounds = has_bounds
		enemy.position = Vector2(rand_range(minX, maxX), rand_range(minY, maxY))
		container.add_child(enemy)
	pass

func GenerateHorizontalPositionEnemy(container, enemyScene, groupName, count, xPos, yPos, direction, has_bounds):
	for i in range(count):
		var enemy = enemyScene.instance()
		enemy.add_to_group(groupName)
		enemy.speed = enemy.speed * GetDirectionValue(direction)
		enemy.has_bounds = has_bounds
		enemy.position = Vector2(xPos + (i * enemy.get_modified_size()), yPos)
		container.add_child(enemy)
	pass

func GenerateVerticalPositionEnemy(container, enemyScene, groupName, count, xPos, yPos, direction, has_bounds):
	for i in range(count):
		var enemy = enemyScene.instance()
		enemy.add_to_group(groupName)
		enemy.speed = enemy.speed * GetDirectionValue(direction)
		enemy.has_bounds = has_bounds
		enemy.position = Vector2(xPos, yPos + (i * enemy.get_modified_size()))
		container.add_child(enemy)
	pass

func GenerateDiagonalPositionEnemy(container, enemyScene, groupName, count, xPos, yPos, alignment, direction, has_bounds):
	for i in range(count):
		
		var enemy = enemyScene.instance()
		enemy.add_to_group(groupName)
		enemy.speed = enemy.speed * GetDirectionValue(direction)
		enemy.has_bounds = has_bounds
		var size = enemy.get_modified_size()
		if (alignment == "\\"):
			enemy.position = Vector2(xPos, yPos) + (i * Vector2(size, size))
		if (alignment == "/"):
			enemy.position = Vector2(xPos, yPos) + (i * Vector2(-size, size))
		container.add_child(enemy)
		pass
	pass

func GenerateRandomPositionHorizontalMovementEnemy(container, enemyScene, groupName, count, minX, maxX, minY, maxY, direction, has_bounds):
	
	for i in range(count):
		
		var enemy = enemyScene.instance()
		enemy.add_to_group(groupName)
		enemy.is_vertical = false
		enemy.speed = enemy.speed * direction
		enemy.position = Vector2(rand_range(minX, maxX), rand_range(minY, maxY))
		container.add_child(enemy)
	pass

func GenerateRandomPositionVerticalMovementEnemy(container, enemyScene, groupName, count, minX, maxX, minY, maxY, minBoundX, minBoundY, direction, has_bounds):
	
	var counter = 0
	for i in range(count):
		
		var enemy = enemyScene.instance()
		enemy.add_to_group(groupName)
		enemy.is_vertical = true
		enemy.speed = enemy.speed * direction
		enemy.extended_bounds = Vector2(minBoundX, minBoundY)
		enemy.position = Vector2(rand_range(minX, maxX), rand_range(minY, maxY))
		container.add_child(enemy)
		counter += 1
	prints(enemyScene.resource_path, " ", counter, " ", container.get_child_count())
	pass

# Helper Methods
func GetDirectionValue(direction):
	var values = [1, -1]
	if direction == 0:
		return values[randi() % values.size()]
	return direction;