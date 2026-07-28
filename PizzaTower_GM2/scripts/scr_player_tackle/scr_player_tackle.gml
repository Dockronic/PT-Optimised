function scr_player_tackle()
{
	combo = 0;
	mach2 = 0;
	hsp = -xscale * movespeed;
	jumpAnim = true;
	landAnim = false;
	crouchAnim = true;
	if (sprite_index != spr_player_lungehit && sprite_index != spr_player_kungfu1 && sprite_index != spr_player_kungfu2 && sprite_index != spr_player_kungfu3 && sprite_index != spr_playerN_backkick && sprite_index != spr_playerN_tackle)
	{
		if (sprite_index != spr_golfswing)
		{
			if (grounded && vsp > 0.5)
			{
				state = states.normal;
			}
		}
		else if (ANIMATION_END && grounded)
		{
			state = states.normal;
		}
	}
	else
	{
		invtime = 30;
		movespeed = Approach(movespeed, 0, 0.1);
		if (ANIMATION_END && grounded && vsp > 0)
		{
			state = states.normal;
		}
	}
	if (floor(image_index) != (image_number - 1))
	{
		image_speed = 0.35;
	}
	else
	{
		image_speed = 0;
	}
}
