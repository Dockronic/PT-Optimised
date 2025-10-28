image_index = 0.35;
with (instance_create(x, y - 20, obj_grabmarker))
{
	ID = other.id;
	other.ID = id;
}
depth = 10;
