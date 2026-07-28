function scr_player_freefallland()
{
	mach2 = 0;
	jumpAnim = true;
	landAnim = false;
	crouchAnim = false;
	movespeed = 0;
	facehurt = true;
	alarm[4] = 14;
	vsp = 0;
	hsp = 0;
	if (ANIMATION_END)
	{
		facehurt = true;
		sprite_index = spr_facehurtup;
		image_index = 0;
		state = states.normal;
		jumpstop = true;
	}
	image_speed = 0.35;
}
