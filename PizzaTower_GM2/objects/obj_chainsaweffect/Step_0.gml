image_xscale = obj_player.xscale;
if (obj_player.state == states.chainsaw)
{
	x = obj_player.x;
	y = obj_player.y;
}
if (obj_player.state != states.chainsaw)
{
	instance_destroy();
}
image_speed = 0.35;
