extends Node

var lives: int = 3

func loose_life():
	lives -= 1
	SignalManager.on_life_lost_label_update.emit()
	
	# Pause for a second to give the user a chance to realize that they lost a life
	await get_tree().create_timer(1.0).timeout
		
	if lives > 0:
		# Call Game Manager to start the reset process
		GameManager.start_new_round()
	else:
		# Freeze the gameplay
		GameManager.game_started = false
		
		# Alert the player that the game is over and how many points they won
		SignalManager.on_game_over.emit()
		
		# Save the score if it broke the record
		ScoreManager.save_high_score_to_file()

func reset_lives():
	lives = 3
