hsp = image_xscale * 10;
if (place_meeting(x + hsp, y, obj_solid))
{
	instance_create(x, y, obj_canonexplosion);
	instance_destroy();
}
scr_collide();
