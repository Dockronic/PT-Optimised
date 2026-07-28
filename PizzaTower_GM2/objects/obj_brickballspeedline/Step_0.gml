if (!instance_exists(obj_player))
{
	instance_destroy();
	exit;
}
x = obj_player.x;
y = obj_player.y;
image_xscale = obj_player.image_xscale;
