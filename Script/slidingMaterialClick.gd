extends KinematicBody2D

#preload de draggedMaterial prefab
var DraggedMaterial = load("res://Scene/DraggedMaterial.tscn");

func _process(delta):
	pass

func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		#When left button is pressed, disable the collision box and create a dragged version of the material
		if event.button_index == BUTTON_LEFT && event.pressed:
			$CollisionShape2D.disabled = true;
			createDraggedMaterial(viewport.get_mouse_position()-self.position);

func createDraggedMaterial(diff):
		#Create a new draggec Material, set the correct dif, position, color and name of the dragged Material
		var draggedMaterial = DraggedMaterial.instance();
		draggedMaterial.diff = diff;
		draggedMaterial.position=self.position;
		draggedMaterial.get_node("Sprite").modulate = $Sprite.modulate;
		draggedMaterial.materialName = get_owner().materialName;
		
		#Make the sliding material transparent and connect the two signal with methode
		$Sprite.modulate.a = 0.3;
		draggedMaterial.connect("inRecipe", self, "_on_inRecipe");
		draggedMaterial.connect("inSpace", self, "_on_inSpace");
		get_owner().add_child(draggedMaterial);
		
func _on_inRecipe():
	#If dragged in recipe delete it
	get_owner().queue_free();
	
func _on_inSpace():
	#If not dragged in recipe enable the colision box and restore the correct transparency
	$Sprite.modulate.a = 1;
	$CollisionShape2D.disabled = false;
