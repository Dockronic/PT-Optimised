
if (ds_list_find_index(global.saveroom, id) == -1)
{
	scr_sleep(5);
	with (instance_create(x + 32, y + 32, obj_parryeffect))
	{
		sprite_index = spr_bigpizzablockdead;
	}
	if (content == noone)
	{
		global.combotime += 50;
		global.combotime = clamp(global.combotime, 0, 60);
		global.collect += 100;
		scr_sound_multiple("event:/sfx/misc/collect", x, y);
		with (instance_create(x + 16, y, obj_smallnumber))
		{
			number = string(100);
		}
	}
	else
	{
		instance_create(x + 32, y, content);
	}
	notification_push(notifications.destroyable_destroyed, [room]);
	tile_layer_delete_at(1, x, y);
	tile_layer_delete_at(1, x + 32, y);
	tile_layer_delete_at(1, x + 32, y + 32);
	tile_layer_delete_at(1, x, y + 32);
	scr_sound_multiple("event:/sfx/misc/breakblock", x, y);
	ds_list_add(global.saveroom, id);
}
