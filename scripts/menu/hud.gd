extends CanvasLayer

var gameInstance
var time = ""
var player

func _process(_delta):
	if Globals.game_state:
		var minutes = str(int(gameInstance.timer / 60))
		var seconds = str(int(((gameInstance.timer / 60.0) - int(minutes)) * 60))
		if int(seconds) < 10:
			seconds = "0"+seconds
		time += minutes
		time += ":"
		time += seconds
		$gameTimerLabel.text = time
		time = ""
		
		# Health Label
		$playerHealthLabel.text = str(Globals.p_health)
		
		if gameInstance.label:
			$WaveLabel.text = "Wave "+str(gameInstance.current_wave)
		else:
			$WaveLabel.text = ""
	else:
		$gameTimerLabel.visible = false
		$playerHealthLabel.visible = false
		$WaveLabel.visible = false
	
	
