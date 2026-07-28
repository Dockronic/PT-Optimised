
if (sprite_index == spr_player_ratmountgameover && !gusrat)
{
	gusrat = true;
	with (create_debris(x, y, spr_ratblock_dead))
	{
		image_xscale = other.image_xscale;
		hsp = -image_xscale * 4;
		vsp = -8;
		image_angle = 0;
	}
}
if (state != states.grabbed && state != states.hit && (state != states.stun || (grounded && vsp > 0)))
{
	instance_destroy();
}
switch (state)
{
	case states.idle:
		scr_enemy_idle();
		break;
	case states.walk:
		scr_enemy_walk();
		break;
	case states.hit:
		scr_enemy_hit();
		break;
	case states.stun:
		scr_enemy_stun();
		break;
	case states.pizzagoblinthrow:
		scr_pizzagoblin_throw();
		break;
	case states.grabbed:
		scr_enemy_grabbed();
		break;
	case states.staggered:
		scr_enemy_staggered();
		break;
	case states.pizzaheadjump:
		scr_enemy_pizzaheadjump();
		break;
}
if (state == states.stun && stunned > 100 && !birdcreated)
{
	birdcreated = true;
	with (instance_create(x, y, obj_enemybird))
	{
		ID = other.id;
	}
}
if (state != states.stun)
{
	birdcreated = false;
}
if (flash && alarm[2] <= 0)
{
	alarm[2] = 0.15 * room_speed;
}
scr_scareenemy();
var player = instance_nearest(x, y, obj_player);
if (state != states.grabbed)
{
	depth = 0;
}
if (state != states.stun)
{
	thrown = false;
}
if (!boundbox)
{
	with (instance_create(x, y, obj_baddiecollisionbox))
	{
		sprite_index = other.sprite_index;
		mask_index = other.sprite_index;
		baddieID = other.id;
		other.boundbox = true;
	}
}
