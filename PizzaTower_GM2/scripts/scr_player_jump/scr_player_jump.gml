function state_player_jump()
{
	var maxmovespeed = 8;
	var maxmovespeed2 = 6;
	var turnmovespeed = 2;
	var accel = 0.5;
	var deccel = 0.1;
	var jumpspeed = -11;
	var machspeed = 6;
	landAnim = true;
	if (!momemtum)
	{
		hsp = move * movespeed;
	}
	else
	{
		hsp = xscale * movespeed;
	}
	hsp += (railmovespeed * raildir);
	if (key_taunt2)
	{
		input_finisher_buffer = 60;
		input_attack_buffer = 0;
		input_up_buffer = 0;
	}
	if (dir != xscale)
	{
		dir = xscale;
		movespeed = turnmovespeed;
		facehurt = false;
	}
	if (move != xscale)
	{
		movespeed = turnmovespeed;
	}
	move = key_left + key_right;
	if (movespeed == 0)
	{
		momemtum = false;
	}
	if (scr_solid(x + hsp, y))
	{
		movespeed = 0;
		mach2 = 0;
	}
	if (move != 0)
	{
		xscale = move;
		if (movespeed < maxmovespeed)
		{
			movespeed += accel;
		}
		else if (floor(movespeed) == maxmovespeed)
		{
			movespeed = maxmovespeed2;
		}
		if (scr_solid(x + xscale, y) && move == xscale)
		{
			movespeed = 0;
		}
	}
	else
	{
		movespeed = 0;
	}
	if (movespeed > maxmovespeed)
	{
		movespeed -= deccel;
	}
	if (ladderbuffer > 0)
	{
		ladderbuffer--;
	}
	if (!jumpstop)
	{
		if (!key_jump2 && vsp < 0.5 && !stompAnim)
		{
			vsp /= 20;
			jumpstop = true;
		}
		else if (scr_solid(x, y - 1) && !jumpAnim)
		{
			vsp = grav;
			jumpstop = true;
		}
	}
	if (global.mort && (sprite_index == spr_mortdoublejump || sprite_index == spr_mortdoublejumpstart))
	{
		if (vsp > 6)
		{
			vsp = 6;
		}
		if (!key_jump2)
		{
			grav = 0.5;
			sprite_index = spr_fall;
		}
	}
	if (key_jump)
	{
		if (global.mort && sprite_index != spr_mortdoublejump)
		{
			repeat (6)
			{
				create_debris(x, y, spr_feather);
			}
			sprite_index = spr_mortdoublejump;
			image_index = 0;
			jumpstop = false;
			grav = 0.25;
			mort = true;
		}
	}
	if (can_jump && input_buffer_jump > 0 && !key_down && !key_attack && vsp > 0 && !(sprite_index == spr_facestomp || sprite_index == spr_freefall))
	{
		input_buffer_jump = 0;
		scr_fmod_soundeffect(jumpsnd, x, y);
		stompAnim = false;
		vsp = jumpspeed;
		state = states.jump;
		jumpAnim = true;
		jumpstop = false;
		if (sprite_index != spr_shotgunshoot)
		{
			sprite_index = spr_jump;
			if (shotgunAnim)
			{
				sprite_index = spr_shotgunjump;
			}
			if (global.pistol && ispeppino)
			{
				sprite_index = spr_player_pistoljump1;
			}
			image_index = 0;
		}
		particle_set_scale(particletypes.highjumpcloud2, xscale, 1);
		create_particle(x, y, particletypes.highjumpcloud2, 0);
	}
	if (!can_jump && !ispeppino && key_up && noisedoublejump && input_buffer_jump > 0 && !key_down && !key_attack)
	{
		scr_player_do_noisecrusher();
	}
	if (grounded && vsp > 0)
	{
		if (vsp > 0 && (!key_attack || sprite_index == spr_suplexbump))
		{
			fmod_event_one_shot_3d("event:/sfx/pep/step", x, y);
			if (key_attack || sprite_index == spr_shotgunshoot)
			{
				landAnim = false;
			}
			if (sprite_index == spr_mortdoublejump || sprite_index == spr_mortdoublejumpstart)
			{
				sprite_index = spr_player_mortland;
			}
			if (sprite_index != spr_shotgunshoot)
			{
				image_index = 0;
			}
			if (global.pistol && ispeppino)
			{
				sprite_index = spr_player_pistolland;
			}
			input_buffer_secondjump = 0;
			state = states.normal;
			jumpAnim = true;
			jumpstop = false;
			create_particle(x, y, particletypes.landcloud, 0);
		}
	}
	if (vsp > 5 && sprite_index != spr_mortdoublejump)
	{
		fallinganimation++;
	}
	if (fallinganimation >= 40 && fallinganimation < 80)
	{
		sprite_index = spr_facestomp;
	}
	else if (fallinganimation >= 80)
	{
		sprite_index = spr_freefall;
	}
	if (!stompAnim)
	{
		if (!jumpAnim)
		{
			switch (sprite_index)
			{
				case spr_mortdoublejumpstart:
					sprite_index = spr_mortdoublejump;
					break;
				case spr_suplexland:
					sprite_index = spr_fall;
					break;
				case spr_playerN_doublejump:
					sprite_index = spr_playerN_doublejumpfall;
					break;
				case spr_airdash1:
					sprite_index = spr_airdash2;
					break;
				case spr_player_pistolshot:
					sprite_index = spr_player_pistoljump2;
					break;
				case spr_shotgunjump:
					sprite_index = spr_shotgunfall;
					break;
				case spr_jump:
					sprite_index = spr_fall;
					break;
				case spr_player_pistoljump1:
					sprite_index = spr_player_pistoljump2;
					break;
				case spr_suplexcancel:
					sprite_index = spr_fall;
					break;
				case spr_player_backflip:
					sprite_index = spr_fall;
					break;
				case spr_player_Sjumpstart:
					sprite_index = spr_player_Sjump;
					break;
				case spr_player_shotgunjump1:
					sprite_index = spr_player_shotgunjump2;
					break;
				case spr_stompprep:
					sprite_index = spr_stomp;
					break;
			}
		}
	}
	else if (sprite_index == spr_stompprep && ANIMATION_END)
	{
		sprite_index = spr_stomp;
	}
	if (scr_check_groundpound())
	{
		input_buffer_slap = 0;
		if (!shotgunAnim)
		{
			sprite_index = spr_bodyslamstart;
			image_index = 0;
			state = states.freefall;
			pistolanim = noone;
			vsp = -6;
		}
		else if (ispeppino)
		{
			fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, y);
			sprite_index = spr_shotgunjump1;
			image_index = 0;
			state = states.freefall;
			vsp = -11;
			with (instance_create(x, y, obj_shotgunblast))
			{
				sprite_index = spr_shotgunblastdown;
				with (bulletID)
				{
					sprite_index = other.sprite_index;
					mask_index = other.mask_index;
				}
			}
		}
		else
		{
			notification_push(notifications.shotgun_shot, [room]);
			state = states.shotgunshoot;
			minigunshot = 3;
			minigunbuffer = 0;
			sprite_index = spr_playerN_minigundown;
			image_index = 0;
		}
	}
	if (sprite_index == spr_player_suplexcancel)
	{
		image_speed = 0.4;
	}
	else
	{
		image_speed = 0.35;
	}
	if (grounded && (sprite_index == spr_facestomp || sprite_index == spr_freefall))
	{
		fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
		image_index = 0;
		sprite_index = spr_bodyslamland;
		state = states.freefallland;
		with (obj_baddie)
		{
			if (shakestun && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0)
			{
				vsp = -7;
				hsp = 0;
			}
		}
		with (obj_camera)
		{
			shake_mag = 10;
			shake_mag_acc = 30 / room_speed;
		}
	}
	if (input_buffer_slap > 0 && !key_up && sprite_index != spr_suplexbump && !shotgunAnim && !global.pistol)
	{
		input_buffer_slap = 0;
		particle_set_scale(particletypes.jumpdust, xscale, 1);
		create_particle(x, y, particletypes.jumpdust, 0);
		image_index = 0;
		sprite_index = spr_suplexdashjumpstart;
		fmod_event_instance_play(suplexdashsnd);
		state = states.handstandjump;
		movespeed = 5;
	}
	else if (input_buffer_slap > 0 && key_up && !shotgunAnim && (!global.pistol || !ispeppino))
	{
		input_buffer_slap = 0;
		state = states.punch;
		image_index = 0;
		sprite_index = spr_breakdanceuppercut;
		fmod_event_instance_play(snd_uppercut);
		if (ispeppino)
		{
			vsp = -10;
		}
		else
		{
			vsp = -21;
		}
		movespeed = hsp;
		if (key_attack && grounded)
		{
			movespeed = abs(hsp);
		}
		particle_set_scale(particletypes.highjumpcloud2, xscale, 1);
		create_particle(x, y, particletypes.highjumpcloud2, 0);
		if (!ispeppino)
		{
			repeat (4)
			{
				with (instance_create(x + irandom_range(-40, 40), y + irandom_range(-40, 40), obj_explosioneffect))
				{
					sprite_index = spr_shineeffect;
					image_speed = 0.35;
				}
			}
		}
	}
	if (input_buffer_shoot > 0)
	{
		if (shotgunAnim)
		{
			scr_shotgunshoot();
		}
		else if (global.pistol)
		{
			scr_pistolshoot(states.jump);
		}
	}
	if (key_slap2 && shoot)
	{
		if (!shotgunAnim)
		{
			flash = true;
			if (!instance_exists(parry_inst) && flash)
			{
				parry_inst = instance_create(x, y, obj_parryhitbox);
				with (parry_inst)
				{
					image_xscale = other.xscale;
				}
			}
			if (global.mort)
			{
				with (instance_create(x + (xscale * 20), y, obj_shotgunbullet))
				{
					image_xscale = other.xscale;
					sprite_index = spr_mortprojectile;
				}
				sprite_index = spr_mortthrow;
				image_index = 0;
				state = states.pistol;
				mort = true;
				with (obj_camera)
				{
					shake_mag = 3;
					shake_mag_acc = 3 / room_speed;
				}
			}
			else if (shoot)
			{
				sprite_index = spr_pistolshot;
				image_index = 0;
				movespeed = 5;
				state = states.handstandjump;
				shoot = true;
				with (obj_camera)
				{
					shake_mag = 3;
					shake_mag_acc = 3 / room_speed;
				}
				if (ispeppino)
				{
					with (instance_create(x + (xscale * 20), y, obj_shotgunbullet))
					{
						pistol = true;
						sprite_index = spr_peppinobullet;
						image_xscale = other.xscale;
					}
				}
				else
				{
					with (instance_create(x, y, obj_playerbomb))
					{
						kick = true;
						movespeed = 15;
						image_xscale = other.xscale;
					}
				}
			}
		}
	}
	if (key_attack && grounded && fallinganimation < 40)
	{
		sprite_index = spr_mach1;
		image_index = 0;
		state = states.mach2;
		if (movespeed < machspeed)
		{
			movespeed = machspeed;
		}
	}
	if (!key_attack || move != xscale)
	{
		mach2 = 0;
	}
	if (ANIMATION_END)
	{
		jumpAnim = false;
	}
	if (sprite_index == spr_playerN_ratballoonbounce && ANIMATION_END)
	{
		image_index = image_number - 1;
	}
	scr_dotaunt();
	if (sprite_index == spr_shotgunshoot)
	{
		landAnim = false;
		machslideAnim = false;
		image_speed = 0.45;
		if (image_index > (image_number - 1))
		{
			sprite_index = spr_shotgunfall;
		}
	}
	if (place_meeting(x, y, obj_solid))
	{
		state = states.crouch;
		landAnim = false;
		crouchAnim = true;
		image_index = 0;
		idle = 0;
	}
}

function scr_player_jump()
{
	state_player_jump();
}
