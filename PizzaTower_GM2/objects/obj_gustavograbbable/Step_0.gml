
switch (state)
{
	case states.idle:
		scr_enemy_idle();
		break;
	case states.walk:
		sprite_index = spr_lonegustavo_grabbable;
		image_speed = 0.35;
		hsp = 0;
		var _boss = noone;
		with (obj_baddie)
		{
			if (object_index != obj_gustavograbbable)
			{
				_boss = id;
			}
		}
		if (_boss != noone)
		{
			if (_boss.x != x)
			{
				image_xscale = sign(_boss.x - x);
			}
		}
		break;
	case states.hit:
		scr_enemy_hit();
		break;
	case states.stun:
		scr_enemy_stun();
		if (sprite_index == spr_dead)
		{
			sprite_index = spr_lonegustavo_dashjump;
		}
		break;
	case states.pizzagoblinthrow:
		scr_pizzagoblin_throw();
		break;
	case states.pizzaheadjump:
		scr_boss_pizzaheadjump();
		break;
	case states.grabbed:
		scr_enemy_grabbed();
		break;
	case states.staggered:
		scr_enemy_staggered();
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
if (state == states.pizzaheadjump && obj_player.state != states.handstandjump && place_meeting(x, y, obj_solid))
{
	invincible = true;
}
else
{
	invincible = false;
}
