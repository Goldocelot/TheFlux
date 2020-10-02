extends Node2D

#Name of the material
export(String) var materialName;

#Color of the Material
export(Color) var materialColor;

#Movement speed
export(int) var speed = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	#Set the correct color
	$KinematicBody2D/Sprite.modulate = materialColor;
	
func _process(delta):
	#Create a horizontal movement
	$KinematicBody2D.position+= Vector2(speed,0);


func _on_VisibilityNotifier2D_screen_exited():
	#When the material left the screen, delete it
	queue_free();
