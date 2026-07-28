
if (obj_player.state != states.hurt && !global.cheesefollow)
{
	ds_list_add(global.saveroom, id);
	if (global.toppintotal < 5)
	{
	}
	obj_tv.showtext = true;
	obj_tv.alarm[0] = 150;
	global.toppintotal += 1;
	global.cheesefollow = true;
	panic = false;
}
