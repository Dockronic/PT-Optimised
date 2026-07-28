visible = (room == rank_room || room == timesuproom) ? false : obj_player.visible;
if (state != states.backbreaker)
{
	if (object_index != obj_pizzakinpineapple || (sprite_index != spr_monsterpineapple_pose1 && sprite_index != spr_monsterpineapple_pose2 && sprite_index != spr_monsterpineapple_pose3))
	{
		if (sprite_index == spr_intro && ANIMATION_END)
		{
			sprite_index = spr_idle;
		}
		if (sprite_index != spr_intro)
		{
			image_alpha = obj_player.image_alpha;
			sprite_index = (xprev != x) ? spr_run : spr_idle;
			depth = -6;
		}
		if (global.panic && sprite_index == spr_idle && !instance_exists(obj_ghostcollectibles))
		{
			sprite_index = spr_panic;
		}
	}
	else if (object_index == obj_pizzakinpineapple)
	{
		if (image_index > (image_number - 1))
		{
			image_index = 0;
			sprite_index = spr_toppinpineapple;
		}
	}
	if (obj_player.state == states.backbreaker)
	{
		instance_create(x, y, obj_tinytaunt);
		sprite_index = spr_taunt;
		image_index = irandom(sprite_get_number(spr_taunt) - 1);
		state = states.backbreaker;
		lock = true;
	}
}
else
{
	hsp = 0;
	vsp = 0;
	if (sprite_index != spr_intro)
	{
		var s = obj_player.sprite_index;
		if (s == obj_player.spr_supertaunt1 || s == obj_player.spr_supertaunt2 || s == obj_player.spr_supertaunt3 || s == obj_player.spr_supertaunt4 || s == 2685)
		{
			sprite_index = spr_intro;
			image_index = 0;
		}
	}
	if (obj_player.state != states.backbreaker || (sprite_index == spr_intro && ANIMATION_END))
	{
		instance_destroy(obj_tinytaunt);
		interp = 0;
		sprite_index = spr_idle;
		lock = false;
		state = states.normal;
	}
}
