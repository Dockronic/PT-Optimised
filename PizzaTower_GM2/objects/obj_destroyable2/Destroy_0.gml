
if (ds_list_find_index(global.saveroom, id) == -1)
{
	repeat (6)
	{
		with (create_debris(x + 16, y, sprite_index))
		{
			if (sprite_index == spr_destroyable2)
			{
				sprite_index = spr_debris;
			}
			else
			{
				sprite_index = spr_halloweendebris;
			}
		}
	}
	with (instance_create(x + 16, y + 16, obj_parryeffect))
	{
		sprite_index = spr_pizzablockdead;
	}
	scr_sleep(5);
	scr_sound_multiple("event:/sfx/misc/collect", x, y);
	global.combotime += 10;
	global.combotime = clamp(global.combotime, 0, 60);
	global.collect += 10;
	with (instance_create(x + 16, y, obj_smallnumber))
	{
		number = string(10);
	}
	tile_layer_delete_at(1, x, y);
	notification_push(notifications.destroyable_destroyed, [room]);
	scr_sound_multiple("event:/sfx/misc/breakblock", x, y);
	ds_list_add(global.saveroom, id);
}
