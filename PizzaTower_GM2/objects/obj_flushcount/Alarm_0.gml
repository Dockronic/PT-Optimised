if (count > 0)
{
	count--;
	scr_sound_multiple("event:/sfx/misc/collect", obj_player.x, obj_player.y);
	global.combotime += 10;
	global.combotime = clamp(global.combotime, 0, 60);
	global.collect += val;
	create_collect(obj_player.x, obj_player.y, spr, val);
	with (instance_create(obj_player.x, obj_player.y, obj_smallnumber))
	{
		number = string(other.val);
	}
	alarm[0] = timer;
}
else
{
	instance_destroy();
}
