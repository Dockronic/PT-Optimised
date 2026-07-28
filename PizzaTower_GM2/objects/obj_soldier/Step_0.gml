
switch (state)
{
	case states.idle:
		if (sprite_index != spr_soldier_idleend)
		{
			scr_enemy_idle();
		}
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
var player = instance_nearest(x, y, obj_player);
switch (state)
{
	case states.idle:
		if (bush)
		{
			var col = collision_line(x, y, player.x, player.y, obj_solid, false, true);
			var col2 = collision_line(x, y, player.x, player.y, obj_slope, false, true);
			var colX = player.x > (x - threshold_x) && player.x < (x + threshold_x);
			var colY = player.y > (y - threshold_y) && player.y < (y + threshold_y);
			if (sprite_index != scaredspr && col == noone && col2 == noone && colX && colY)
			{
				if (x != player.x)
				{
					image_xscale = sign(player.x - x);
				}
				bush = false;
				sprite_index = spr_soldier_idleend;
				image_index = 0;
			}
		}
		else if (sprite_index == spr_soldier_idleend && ANIMATION_END)
		{
			state = states.walk;
			sprite_index = spr_soldier_walk;
		}
		break;
	case states.charge:
		hsp = Approach(hsp, 0, 0.5);
		if (sprite_index == spr_soldier_shootstart && ANIMATION_END)
		{
			sprite_index = spr_soldier_shoot;
		}
		if (sprite_index != spr_soldier_shootstart)
		{
			if (bullet_count > 0)
			{
				if (can_fire)
				{
					can_fire = false;
					alarm[5] = fire_max;
					bullet_count--;
					sprite_index = spr_soldier_shoot;
					image_index = 0;
					hsp -= (image_xscale * recoil_spd);
					with (instance_create(x, y, obj_enemybullet))
					{
						fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, y);
						image_xscale = other.image_xscale;
					}
				}
			}
			else if (ANIMATION_END)
			{
				sprite_index = walkspr;
				attack_cooldown = attack_max;
				state = states.walk;
			}
		}
		break;
	case states.walk:
		if (attack_cooldown > 0)
		{
			attack_cooldown--;
		}
		else
		{
			var col = collision_line(x, y, player.x, player.y, obj_solid, false, true);
			var col2 = collision_line(x, y, player.x, player.y, obj_slope, false, true);
			var colX = player.x > (x - threshold_x) && player.x < (x + threshold_x);
			var colY = player.y > (y - threshold_y) && player.y < (y + threshold_y);
			if (sprite_index != scaredspr && col == noone && col2 == noone && colX && colY)
			{
				if (x != player.x)
				{
					image_xscale = sign(player.x - x);
				}
				sprite_index = spr_soldier_shootstart;
				image_index = 0;
				state = states.charge;
				bullet_count = bullet_max;
				can_fire = true;
			}
		}
		break;
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
