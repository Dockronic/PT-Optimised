
if (global.collectsound < 10)
{
	global.collectsound += 1;
}
if (place_meeting(x, y, obj_destructibles))
{
	depth = 102;
}
else
{
	depth = 2;
}
if (global.panic || instance_exists(obj_wartimer))
{
	image_alpha = 1;
	if (!gotowardsplayer && distance_to_object(obj_player) < 25)
	{
		gotowardsplayer = true;
		scr_ghostcollectible();
	}
	if (gotowardsplayer)
	{
		move_towards_point(obj_player.x, obj_player.y, movespeed);
		movespeed++;
	}
}
