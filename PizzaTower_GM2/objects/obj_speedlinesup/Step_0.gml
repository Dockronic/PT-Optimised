x = obj_player.x;
y = obj_player.y;
depth = obj_player.depth - 1;
if (obj_player.vsp > 0)
{
	fade = true;
}
if (fade)
{
	image_alpha -= 0.1;
}
if (image_alpha <= 0)
{
	instance_destroy();
}
