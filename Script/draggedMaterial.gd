extends KinematicBody2D

#Signal used to know what to do with this element
signal inRecipe;
signal inSpace;

#diff between the sprite origine and the mouse position
var diff : Vector2;

#lastRecipe colided
var lastRecipe : Area2D;

#Name of the material
var materialName : String;
	
func _process(delta):
	#Deplacement of the element with the mouse
	var mousepos = get_viewport().get_mouse_position();
	self.position = Vector2(mousepos.x-diff.x, mousepos.y-diff.y);

func _input(event):
	if event is InputEventMouseButton:
		#When the left button is release
		if event.button_index == BUTTON_LEFT && !event.pressed:
			#If the material is colliding with a recipe and if this recipe need this material emit the signal and add the material
			if lastRecipe != null && lastRecipe.overlaps_body(self) && lastRecipe.needMaterial(self):
				emit_signal("inRecipe");
				lastRecipe.addMaterial(self);
			else:
				#If the material is not colliding emit the correct signal
				emit_signal("inSpace");
			queue_free()

