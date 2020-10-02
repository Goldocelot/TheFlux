extends Area2D

#Load the draggedMaterial type and the list of possible Matierial
const DraggedMaterial = preload("res://Script/draggedMaterial.gd");
const INGREDIENTS = preload("res://Script/materialEnum.gd").INGREDIENTS;

signal addScore(amount);

#The spawner link to the recipe
var spawner : Node2D;

#List of Ingredients name and sprite for the instance of the recipe
var ingredientsName = Array();
var ingredientsSprite = Array();

#Number of ingredient
var nbIngredient;

func _ready():
	#Choose a random number of material
	nbIngredient = (randi() % 4)+1;
	
	#Generate new ingredient with different name to match the number attended
	while ingredientsName.size()<nbIngredient:
		#generate a random number and get the correct key in the list
		var rand = randi() % INGREDIENTS.size();
		var key = INGREDIENTS.keys()[rand];
		#If the material is not already in this recipe
		if ingredientsName.find(key) == -1:
			#Load a sprite of the material required with the correct color and the correct size
			var sprite = Sprite.new();
			sprite.texture = load("res://Sprite/Material.png")
			sprite.modulate = INGREDIENTS[key];
			sprite.scale = Vector2(2,2);
			#Add the sprite and the name inside the two list
			ingredientsSprite.insert(ingredientsName.size(),sprite);
			ingredientsName.insert(ingredientsName.size(),key);
			#Position the material
			sprite.position = Vector2(0,-102+64*(ingredientsName.size()-1));
			add_child(sprite)
	
	
func _on_Recipe_body_entered(body):
	#When a material collid with the recipe, set the last recipe of the material to this recipe
	if body is DraggedMaterial:
		body.lastRecipe = self;
		
#Return if the material is needed
func needMaterial(material):
	return ingredientsName.find(material.materialName) != -1;


func addMaterial(material):
	#add 5 to the score
	emit_signal("addScore",5);
	#Look after the correct index of the material and remove it from the both list and from the game
	var index = ingredientsName.find(material.materialName)
	ingredientsName.remove(index);
	ingredientsSprite[index].queue_free();
	ingredientsSprite.remove(index);
	
	#If it was the last ingredient, increase the score, spawn a new recipe and remove the done recipe
	if ingredientsName.empty():
		emit_signal("addScore",5*nbIngredient);
		spawner.spawn();
		queue_free();
