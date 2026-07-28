function scr_player_addslopemomentum(_accel, _decel)
{
	with (instance_place(x, y + 1, obj_slope))
	{
		if (sign(image_xscale) == -sign(other.xscale))
		{
			if (abs(image_yscale) < abs(image_xscale))
			{
				other.movespeed += _accel;
			}
			else
			{
				other.movespeed += _decel;
			}
		}
	}
}

