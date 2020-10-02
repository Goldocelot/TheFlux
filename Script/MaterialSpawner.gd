extends Node2D

#Load the material list
const INGREDIENTS = preload("res://Script/materialEnum.gd").INGREDIENTS;
#Load the slidingMaterial spawner
var SlidingMaterial = preload("res://Scene/SlidingMaterial.tscn");
#direction of the spawner
export(int) var direction;

func _ready():
	$Timer.start();

func _on_Timer_timeout():
	# randome chance to spawn a SlidingMaterial
	if randi() % 3 != 0:
		#Take a random ingredient and instanciate it
		var rand = randi() % INGREDIENTS.size();
		var slidingMaterial = SlidingMaterial.instance();
		
		#Set the correct name, the correct color and the correct speed
		slidingMaterial.materialName=INGREDIENTS.keys()[rand];
		slidingMaterial.materialColor=INGREDIENTS[INGREDIENTS.keys()[rand]];
		slidingMaterial.speed = slidingMaterial.speed*direction;
		add_child(slidingMaterial);
