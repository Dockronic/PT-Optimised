
switch (state)
{
	case states.idle:
		scr_enemy_idle();
		break;
	case states.charge:
		scr_enemy_charge();
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
scr_scareenemy();
var player = instance_nearest(x, y, obj_player);
if (ragebuffer > 0)
{
	ragebuffer--;
}
if ((player.x > (x - 400) && player.x < (x + 400)) && (y <= (player.y + 60) && y >= (player.y - 60)))
{
	if (x != player.x && grounded)
	{
		if (state == states.walk && !charging)
		{
			fmod_event_instance_play(chargesnd);
			fmod_event_instance_set_3d_attributes(chargesnd, x, y);
			with (instance_create(x, y, obj_forkhitbox))
			{
				ID = other.id;
			}
			charging = true;
			state = states.charge;
			movespeed = 5;
			vsp = -7;
			sprite_index = spr_fencer_chargestart;
		}
	}
}
if (state == states.stun || state == states.walk)
{
	charging = false;
	movespeed = 0;
}
if (sprite_index == spr_fencer_chargestart && ANIMATION_END)
{
	sprite_index = spr_fencer_charge;
}
if (flash && alarm[2] <= 0)
{
	alarm[2] = 0.15 * room_speed;
}
if (!hitboxcreate && (state == states.walk || state == states.rage || state == states.charge))
{
	hitboxcreate = true;
	with (instance_create(x, y, obj_forkhitbox))
	{
		ID = other.id;
	}
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
		baddieID = other.id;
		other.boundbox = true;
	}
}
