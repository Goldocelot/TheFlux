extends Node2D

#Preload the recipe prefab
var Recipe = preload("res://Scene/Recipe.tscn");

signal increaseScore(amout);

func _ready():
	spawn();

func spawn():
	#instanciate a new recispe and connect the addScore signal with the sendScore signal
	var recipe = Recipe.instance();
	recipe.spawner = self;
	recipe.connect("addScore", self, "sendScore");
	add_child(recipe);
	
func sendScore(amount):
	emit_signal("increaseScore", amount);
