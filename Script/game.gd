extends Node2D

var INGREDIENTS = preload("res://Script/materialEnum.gd").INGREDIENTS;
var bestScore;
var score = 0; #Score
var time = 90; #Time left
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	#Init the HUD value and start the timer
	$GAME_HUD.setScore(score);
	$GAME_HUD.setTimer(time);
	$Timer.start();
	
	#Load the bestscore
	var file = File.new();
	file.open("user://score.dat", File.READ);
	bestScore = int(file.get_as_text());
	file.close();

func _on_RecipeSpawner_increaseScore(amout):
	#Increase the score when a correct material is give to a recipe or when the recipe is done
	score+=amout;
	$GAME_HUD.setScore(score);


func _on_Timer_timeout():
	#When the timer of 1 secondes timeout, reduce the left time
	time-=1;
	$GAME_HUD.setTimer(time);
	
	#When time is 
	if time == 0:
		
		#Save the new best score
		if score>bestScore:
			var file = File.new()
			file.open("user://score.dat", File.WRITE)
			file.store_string(String(score))
			file.close()
		
		#Switch scene
		get_tree().change_scene("res://Scene/mainMenu.tscn");
		queue_free();
