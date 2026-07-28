function secret_add(_func1, _func2)
{
	with (obj_secretmanager)
	{
		ds_list_add(secrettriggers, [_func2]);
		if (_func1 != noone)
		{
			method(id, _func1)();
		}
	}
}

function secret_check_trigger(_trigger)
{
	var _found = true;//was false
	if (_found)
	{
		trace(
		{
			found: _found
		});
	}
	return _found;
}

function secret_open_portal(_trigger)
{
	with (obj_secretportal)
	{
		if (trigger == _trigger && ds_list_find_index(global.saveroom, id) == -1 && !place_meeting(x, y, obj_secretblock) && !place_meeting(x, y, obj_secretbigblock) && !place_meeting(x, y, obj_secretmetalblock))
		{
			active = true;
		}
	}
}

function secret_close_portal(_trigger, _quick = false)
{
	with (obj_secretportal)
	{
		if (trigger == _trigger && sprite_index != spr_secretportal_close)
		{
			sprite_index = spr_secretportal_close;
			if (!_quick)
			{
				image_index = 0;
			}
			else
			{
				image_index = 14;
			}
			active = false;
		}
	}
}

