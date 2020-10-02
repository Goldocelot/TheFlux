extends CanvasLayer

var bestScore;

func _ready():
	#Load the bestscore and display it
	var file = File.new();
	file.open("user://score.dat", File.READ);
	var bestScore = file.get_as_text();
	file.close();
	
	$bestScore.text = "BEST SCORE: %s" % bestScore;

func _on_StartButton_pressed():
	#Switch to the game scene
	get_tree().change_scene("res://Scene/game.tscn")
