function scr_player_crouch()
{
	move = key_left + key_right;
	if (!place_meeting(x, y + 1, obj_railparent))
	{
		hsp = move * movespeed;
	}
	else
	{
		var _railinst = instance_place(x, y + 1, obj_railparent);
		hsp = (move * movespeed) + (_railinst.movespeed * _railinst.dir);
	}
	movespeed = 4;
	mask_index = spr_crouchmask;
	if (!grounded && !key_jump)
	{
		jumpAnim = false;
		state = states.crouchjump;
		movespeed = 4;
		crouchAnim = true;
		image_index = 0;
	}
	if (grounded && !key_down && !scr_solid(x, y - 16) && !scr_solid(x, y - 32) && !key_jump)
	{
		state = states.normal;
		movespeed = 0;
		crouchAnim = true;
		jumpAnim = true;
		image_index = 0;
		mask_index = spr_player_mask;
	}
	if (!crouchAnim)
	{
		if (move == 0)
		{
			if (!shotgunAnim)
			{
				sprite_index = spr_crouch;
			}
			else
			{
				sprite_index = spr_shotgunduck;
			}
		}
		if (move != 0)
		{
			if (!shotgunAnim)
			{
				sprite_index = spr_crawl;
			}
			else
			{
				sprite_index = spr_shotguncrawl;
			}
		}
	}
	if (crouchAnim)
	{
		if (move == 0)
		{
			if (!shotgunAnim)
			{
				sprite_index = spr_couchstart;
			}
			else
			{
				sprite_index = spr_shotgungoduck;
			}
			if (ANIMATION_END)
			{
				crouchAnim = false;
			}
		}
	}
	if (move != 0)
	{
		xscale = move;
		crouchAnim = false;
	}
	if (key_jump && grounded && !scr_solid(x, y - 16) && !scr_solid(x, y - 32))
	{
		scr_fmod_soundeffect(jumpsnd, x, y);
		vsp = -8;
		state = states.crouchjump;
		movespeed = 4;
		image_index = 0;
		crouchAnim = true;
		jumpAnim = true;
	}
	image_speed = 0.45;
}
