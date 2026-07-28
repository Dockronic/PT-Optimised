if (ds_list_find_index(global.saveroom, id) == -1)
{
	if (sprite_index == spr_bigbeer)
	{
		repeat (6)
		{
			create_debris(x + random_range(0, sprite_width), y + random_range(0, sprite_height), spr_beerdebris);
		}
	}
	else
	{
		repeat (3)
		{
			create_debris(x + random_range(0, sprite_width), y + random_range(0, sprite_height), spr_beerdebris);
		}
	}
	fmod_event_one_shot_3d("event:/sfx/misc/beerbreak", x, y);
	notification_push(notifications.beer_knocked, [room, id, object_index]);
	global.combotime += 10;
	global.combotime = clamp(global.combotime, 0, 60);
	global.collect += 10;
	create_collect(x, y, spr_beerliquid, 10);
	with (instance_create(x + 16, y, obj_smallnumber))
	{
		number = string(10);
	}
	ds_list_add(global.saveroom, id);
}
