if (ds_list_find_index(global.saveroom, id) == -1)
{
	with (obj_tv)
	{
		showtext = true;
		alarm[0] = 150;
	}
	fmod_event_one_shot("event:/sfx/misc/secretfound");
	ds_list_add(global.saveroom, id);
}
