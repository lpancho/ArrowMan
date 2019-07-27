extends Node

# GAME DEFINED SETTINGS
const BORDER_HEIGHT = 100
const GENERATE_HORIZONTAL_POSITION_ENEMY = "GenerateHorizontalPositionEnemy"
const GENERATE_VERTICAL_POSITION_ENEMY = "GenerateVerticalPositionEnemy"
const GENERATE_DIAGONAL_POSITION_ENEMY = "GenerateDiagonalPositionEnemy"
const GENERATE_RANDOM_POSITION_ENEMY = "GenerateRandomPositionEnemy"
const GENERATE_RANDOM_POSITION_HORIZONTALMOVEMENT_ENEMY = "GenerateRandomPositionHorizontalMovementEnemy"
const GENERATE_RANDOM_POSITION_VERTICALMOVEMENT_ENEMY = "GenerateRandomPositionVerticalMovementEnemy"

const LAST_STAGE_ID = 6

# STAGE DEFINED VALUES
var challenges_dict = {
	"Stages": [{
			"Id": 1,
			"GoldenArrows": false,
			"Messages": [ 
				"Hey Archer!\n\nThe following tests will improve your archery skill!\nTo be a excellent archer you must surpass all of the tests!\n\nYou'll be given of 25 arrows per stage. If you run out of arrows, you lose.\n\nGoodluck!\n\n\n[CLICK] to continue...", 
				"For you first challenge. Hit all the apples that are aligned.\n\nThis is just an easy test and I know you can surpass this by using less than 3 arrows.\n\n\n\n\n\n\n\n[CLICK] to start... "
				],
			"GameOverMessage":[
				"\n\n\nThis is just the first challenge. What are you thinking? Are you really in to it?\nTry again if you wanted to be the next great archer or quit know and hold your pee"
			],
			"Enemies": [{
				"Name": "Apple",
				"Count": 8,
				"Generator": {
					"Name": GENERATE_HORIZONTAL_POSITION_ENEMY,
					"Position": {
						"x": 500,
						"y": 300
					},
					"Align": null,
					"Direction": -1, 
					"HasBounds": false
				}
			}]
		}, {
			"Id": 2,
			"GoldenArrows": false,
			"Messages": [
				"Excellent!\n\nAs I told you, that was an easy start!\n\nApples are great source of fiber, vitamin C, and various antioxidants.\n\nIt is better to eat apples once in a while!\n\nFor your next challenge!\n\n\n[CLICK] to continue...",
				"Bananas!\n\nNow here is vertically aligned bananas.\n\nThey said that you can finish this only by using arrows the same count of bananas.\n\nBut no one knows what will happen if you try less than the count of bananas.\n\n\n\n[CLICK] to start...",
				],
			"Enemies": [{
				"Name": "Banana",
				"Count": 6,
				"Generator": {
					"Name": GENERATE_VERTICAL_POSITION_ENEMY,
					"Position": {
						"x": 500,
						"y": 300
					},
					"Align": null,
					"Direction": -1, 
					"HasBounds": false
				}
			}]
		}, {
			"Id": 3,
			"GoldenArrows": false,
			"Messages": [
				"Hey! Did you know that bananas come from a family of plants called Musa that are native to Southeast Asia and grown in many of the warmer areas of the world!\n\nOkay! I've said too much!\n\nLet's move on to the next challenge!\n\n\n\n\n\n[CLICK] to continue...",
				"Did something pop in your head? Yeah! That's Cherry!\n\nCherries will be aligned diagonally but you can't hit three cherries at a time.\n\nGive it a try but I've already told you it is  impossible!\n\n\n\n\n\n\n[CLICK] to start..."
				],
			"Enemies": [{
				"Name": "Cherry",
				"Count": 8,
				"Generator": {
					"Name": GENERATE_DIAGONAL_POSITION_ENEMY,
					"Position": {
						"x": 500,
						"y": 300
					},
					"Align": "\\",
					"Direction": 1, 
					"HasBounds": false
				}
			}]
		}, {
			"Id": 4,
			"GoldenArrows": false,
			"Messages": [
				"The term cherry came from the Latin word 'cerasum', which is the city where the cherry was first exported to Europe.\n\nAlso, I cherry tree produces about 7,000 cherries!\n\n\n\n\n\n\n\n[CLICK] to continue...",
				"Here are the grapes!\n\nDid you know that there are 8,000 grape varieties from about 60 species?\nYou've guess already how many grapes you are going to hit today, didn't you?\n\nThere are 60 grapes but randomly scattered. Don't quit if you dont finish it with all of your arrows!\n\n\n\n[CLICK] to start..."
				],
			"Enemies": [{
				"Name": "Grapes",
				"Count": 60,
				"Generator": {
					"Name": GENERATE_RANDOM_POSITION_VERTICALMOVEMENT_ENEMY,
					"Position": {
						"RangeX": {
							"x": 200,
							"y": 800
						},
						"RangeY": {
							"x": 600,
							"y": 2000
						}
					},
					"Direction": 1, 
					"HasBounds": false,
					"ExtendedBounds": {
						# this can be range x or y depending on the generator that you are using
						"RangeY": {
							"x": 0,
							"y": 2000
						}
					}
				}
			}]
		}, {
			"Id": 5,
			"GoldenArrows": false,
			"Messages": [
				"You did a great job! Well done!\n\nThe feeling that you have successfully hit all 60 grapes with 25 arrows is awesome!\n\n\nFor you next challenge...\n\n\n\n\n\n[CLICK] to continue...",
				"How are you going to feel when 80 kiwifruit start attacking you? Not literally but they are going in front of you.\n\nDon't let any kiwifruit leave the screen!\n\nGood luck!\n\n\n\n\n\n\n[CLICK] to start..."
				],
			"Enemies": [{
				"Name": "Kiwi",
				"Count": 80,
				"Generator": {
					"Name": GENERATE_RANDOM_POSITION_HORIZONTALMOVEMENT_ENEMY,
					"Position": {
						"RangeX": {
							"x": 1024,
							"y": 3000
						},
						"RangeY": {
							"x": 120,
							"y": 550
						}
					},
					"Direction": 1, 
					"HasBounds": false
				}
			}]
		}, {
			"Id": 6,
			"GoldenArrows": true,
			"Messages": [
				"That was fantastic! 80 kiwifruit has been hitted!\n\nKiwi was first discovered in China and quickly became a favorite of Chinese royalty. It was viewed as very special delicacy.\n\nThis was also kwown as Chinese gooseberry!\n\n\n\n\n\n[CLICK] to continue...",
				"This will be the last challenge.\n\nAll you have to do is to hit all fruits that are going to show in the screen\n\nI'll give 5 golden arrows that when used it will spawn 5 random arrows in the screen.\nIt's like shooting 6 arrows at a time.\n\nUse it wisely!\n\n\n[CLICK] to start...",
				],
			"Enemies": [{
				"Name": "Pineapple",
				"Count": 50,
				"Generator": {
					"Name": GENERATE_RANDOM_POSITION_HORIZONTALMOVEMENT_ENEMY,
					"Position": {
						"RangeX": {
							"x": 1024,
							"y": 3000
						},
						"RangeY": {
							"x": 120,
							"y": 550
						}
					},
					"Direction": 1, 
					"HasBounds": false
				}
			}, {
				"Name": "Strawberry",
				"Count": 50,
				"Generator": {
					"Name": GENERATE_RANDOM_POSITION_VERTICALMOVEMENT_ENEMY,
					"Position": {
						"RangeX": {
							"x": 200,
							"y": 800
						},
						"RangeY": {
							"x": 600,
							"y": 1400
						}
					},
					"Direction": 1, 
					"HasBounds": false,
					"ExtendedBounds": {
						# this can be range x or y depending on the generator that you are using
						"RangeY": {
							"x": 0,
							"y": 1400
						}
					}
				}
			}, {
				"Name": "Unripe_Grapes",
				"Count": 100,
				"Generator": {
					"Name": GENERATE_RANDOM_POSITION_VERTICALMOVEMENT_ENEMY,
					"Position": {
						"RangeX": {
							"x": 200,
							"y": 800
						},
						"RangeY": {
							"x": 0,
							"y": -1000
						}
					},
					"Direction": -1, 
					"HasBounds": false,
					"ExtendedBounds": {
						# this can be range x or y depending on the generator that you are using
						"RangeY": {
							"x": -1000,
							"y": 600
						}
					}
				}
			}]
		}
	]
}

# FRUITS DEFINED VALUES
var fruits_dict = {
	"Fruits": [{
		"Name": "Apple",
		"Multiplier": 1,
	},{
		"Name": "Banana",
		"Multiplier": 2,
	},{
		"Name": "Cherry",
		"Multiplier": 3,
	},{
		"Name": "Grapes",
		"Multiplier": 4,
	},{
		"Name": "Kiwi",
		"Multiplier": 5,
	},{
		"Name": "Pineapple",
		"Multiplier": 6,
	},{
		"Name": "Strawberry",
		"Multiplier": 7,
	},{
		"Name": "Unripe_Grapes",
		"Multiplier": 8,
	}]
}

var game_over_message = [
	"Dispite of not finishing the whole challenges does not mean that you are not qualified to be a great archer.\n\nPlay it again and prove that you are worthy to be one of us.\n\nHoping that you can finish all of the challenges.\n\n\n\n[CLICK] to go to Main Menu..."
	]

var end_game_message = [
	"After conquering all the challenges. I would like to congratulate you for being the great archer of all time!\nThis is not a joke but it is up to you if you'll going to accept it! hehe!\n\nI hope you have enjoyed each of the challenges.\n\nAs a token of appreciation. You may now select ENDLESS MODE in the game menu.\n\n\n\n[CLICK] to go to Main Menu..."
	]