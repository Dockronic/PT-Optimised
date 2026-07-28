function scr_player_victory()
{
	hsp = 0;
	mach2 = 0;
	jumpAnim = true;
	landAnim = false;
	crouchAnim = true;
	if (place_meeting(x, y, obj_keydoor) || place_meeting(x, y, obj_geromedoor))
	{
		sprite_index = spr_victory;
	}
	if (place_meeting(x, y, obj_startgate))
	{
		sprite_index = spr_entergate;
	}
	if (ANIMATION_END)
	{
		image_speed = 0;
	}
	else
	{
		image_speed = 0.35;
	}
}
