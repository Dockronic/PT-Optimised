if (other.state != states.gotoplayer)
{
	fmod_event_one_shot("event:/sfx/misc/collectpizza");
	instance_destroy();
	global.combotime = 60;
	global.collect += value;
	if (visible)
	{
		create_collect(x, y, sprite_index, value);
	}
	with (instance_create(x + 16, y, obj_smallnumber))
	{
		number = string(other.value);
	}
	tv_do_expression(spr_tv_exprcollect);
}
