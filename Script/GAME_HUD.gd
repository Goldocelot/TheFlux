extends CanvasLayer

#Function call to change the score displayed
func setScore(score : int):
	$score.text = String(score);
	
#Function call to change the time displayed
func setTimer(timer : int):
	var seconde = timer;
	var minute = seconde/60;
	seconde-= minute*60;
	$timer.text = "%02d:%02d" % [minute , seconde];
