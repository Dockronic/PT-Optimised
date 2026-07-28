
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
