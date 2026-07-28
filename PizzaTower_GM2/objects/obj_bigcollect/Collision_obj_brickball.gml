if (image_alpha == 1 && !place_meeting(x, y, obj_metalblock))
{
	fmod_event_one_shot("event:/sfx/misc/collectpizza");
	instance_destroy();
	global.combotime = 60;
	global.collect += value;
	create_collect(x, y, sprite_index, value);
	with (instance_create(x + 16, y, obj_smallnumber))
	{
		number = string(other.value);
	}
	tv_do_expression(spr_tv_exprcollect);
}
