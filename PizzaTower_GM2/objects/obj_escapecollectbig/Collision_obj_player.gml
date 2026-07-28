
if (image_alpha == 1)
{
	if (other.state != states.gotoplayer)
	{
		global.combotime = 60;
		fmod_event_one_shot_3d("event:/sfx/misc/collectpizza", x, y);
		fmod_event_one_shot_3d("event:/sfx/misc/bellcollectbig", x, y);
		instance_destroy();
		global.collect += value;
		create_collect(x, y, sprite_index, value);
		with (instance_create(x + 16, y, obj_smallnumber))
		{
			number = string(other.value);
		}
	}
}
