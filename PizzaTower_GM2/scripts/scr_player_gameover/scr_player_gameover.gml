function scr_player_gameover()
{
	image_speed = 0.35;
	cutscene = true;
	scale_xs = 1;
	scale_ys = 1;
	visible = true;
	flash = false;
	alarm[0] = -1;
	alarm[1] = -1;
	alarm[3] = -1;
	alarm[4] = -1;
	alarm[5] = -1;
	alarm[6] = -1;
	alarm[7] = -1;
	alarm[8] = -1;
	alarm[9] = -1;
	hurted = false;
	inv_frames = false;
	if (place_meeting(x + floor(hsp), y, noone))
	{
		x = floor(x);
		while (!place_meeting(x + sign(hsp), y, noone))
		{
			x += sign(hsp);
		}
		hsp = 0;
	}
	x += hsp;
	if (place_meeting(x, y + floor(vsp), noone))
	{
		y = floor(y);
		while (!place_meeting(x, y + sign(vsp), noone))
		{
			y += sign(vsp);
		}
		vsp = 0;
	}
	y += floor(vsp);
	if (vsp < 30)
	{
		vsp += grav;
	}
}
