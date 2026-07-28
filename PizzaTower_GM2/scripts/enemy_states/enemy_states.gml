function scr_enemy_charge()
{
	if (object_index == obj_peasanto)
	{
		if (grounded || (grounded && !place_meeting(x, y, obj_platform)))
		{
			hsp = image_xscale * 6;
		}
		image_speed = 0.35;
		if ((scr_solid(x + 1, y) && image_xscale == 1) || (scr_solid(x - 1, y) && image_xscale == -1) || place_meeting(x + hsp, y, obj_hallway))
		{
			if (!place_meeting(x + sign(hsp), y, obj_slope))
			{
				image_xscale *= -1;
			}
		}
		if (!(scr_solid(x + (image_xscale * 15), y + 31) || place_meeting(x + (image_xscale * 15), y + 31, obj_platform)))
		{
			image_xscale *= -1;
		}
		if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp < 0)
		{
			hsp += 0.1;
		}
		else if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp > 0)
		{
			hsp -= 0.1;
		}
		sprite_index = spr_peasanto_flameattack;
	}
	if (object_index == obj_indiancheese)
	{
		if (ANIMATION_END)
		{
			image_speed = 0;
		}
		hsp = image_xscale * movespeed;
		if (grounded && vsp > 0)
		{
			if (place_meeting(x + image_xscale, y, obj_solid))
			{
				image_xscale *= -1;
			}
			state = states.walk;
			image_index = 0;
			image_speed = 0.35;
			sprite_index = spr_indiancheese_land;
		}
	}
	if (object_index == obj_snowman)
	{
		hsp = image_xscale * movespeed;
		image_speed = 0.35;
		sprite_index = spr_newpizzice_walk;
		if (((scr_solid(x + 1, y) && image_xscale == 1) || (scr_solid(x - 1, y) && image_xscale == -1)) && !place_meeting(x + sign(hsp), y, obj_slope))
		{
			image_index = 0;
			sprite_index = spr_newpizzice_turn;
			state = states.idle;
			hsp = 0;
		}
	}
	if (object_index == obj_fencer || object_index == obj_banditochicken)
	{
		if (object_index == obj_fencer)
		{
			if (grounded || (grounded && !place_meeting(x, y, obj_platform)))
			{
				hsp = image_xscale * movespeed;
			}
			else
			{
				hsp = 0;
			}
		}
		else
		{
			hsp = image_xscale * movespeed;
		}
		if (((scr_solid(x + 1, y) && image_xscale == 1) || (scr_solid(x - 1, y) && image_xscale == -1)) && !place_meeting(x + sign(hsp), y, obj_slope))
		{
			image_xscale *= -1;
		}
	}
	if (object_index == obj_ancho)
	{
		hsp = image_xscale * movespeed;
		if (place_meeting(x + hsp, y, obj_solid))
		{
			state = states.stun;
			stunned = 100;
		}
	}
	if (object_index == obj_ninja)
	{
		inv_timer = 5;
		hsp = image_xscale * 2;
		if (grounded && vsp > 0)
		{
			state = states.walk;
			sprite_index = idlespr;
		}
		if (alarm[4] == -1)
		{
			alarm[4] = 5;
		}
	}
	if (place_meeting(x, y + 1, obj_railparent))
	{
		var _railinst = instance_place(x, y + 1, obj_railparent);
		hsp += (_railinst.movespeed * _railinst.dir);
	}
}

function scr_enemy_chase()
{
	if (object_index == obj_minijohn || object_index == obj_banditochicken || object_index == obj_golfdemon)
	{
		var targetplayer = obj_player;
		if (x != targetplayer.x && !(image_xscale == -sign(x - targetplayer.x)))
		{
			movespeed = 4;
			if (object_index == obj_golfdemon)
			{
				movespeed = 6;
			}
			image_xscale = -sign(x - targetplayer.x);
			momentum = -image_xscale * (movespeed + 4);
		}
		hsp = (image_xscale * movespeed) + momentum;
		momentum = Approach(momentum, 0, 0.1);
		if (grounded && vsp > 0)
		{
			steppy--;
		}
		if (steppy <= 0)
		{
			instance_create(x, y + 43, obj_cloudeffect);
			steppy = 20;
		}
	}
	if (object_index == obj_golfdemon)
	{
		invincible = true;
		sprite_index = spr_golfdemon_charge;
	}
	if (place_meeting(x, y + 1, obj_railparent))
	{
		var _railinst = instance_place(x, y + 1, obj_railparent);
		hsp += (_railinst.movespeed * _railinst.dir);
	}
}

function scr_enemy_grabbed()
{
	if (!pepperman_grab)
	{
		image_xscale = -obj_player.xscale;
		stunned = 200;
		obj_player.baddiegrabbedID = id;
		if (obj_player.state == states.grabbing || obj_player.state == states.grab || obj_player.state == states.throwing || obj_player.state == states.slam || obj_player.state == states.tacklecharge)
		{
			x = obj_player.x;
			if (obj_player.sprite_index != obj_player.spr_haulingstart)
			{
				y = obj_player.y - 40;
			}
			else if (floor(obj_player.image_index) == 0)
			{
				y = obj_player.y;
			}
			else if (floor(obj_player.image_index) == 1)
			{
				y = obj_player.y - 10;
			}
			else if (floor(obj_player.image_index) == 2)
			{
				y = obj_player.y - 20;
			}
			else if (floor(obj_player.image_index) == 3)
			{
				y = obj_player.y - 30;
			}
			image_xscale = -obj_player.xscale;
		}
		with (obj_player)
		{
			move = key_left2 + key_right2;
			if (!(state == states.grab || state == states.chainsaw || state == states.finishingblow || state == states.grabbing || state == states.throwing || state == states.slam || state == states.tacklecharge || state == states.punch || state == states.superslam || state == states.backkick || state == states.uppunch))
			{
				other.x = x;
				other.y = y;
				other.state = states.stun;
				other.image_index = 0;
			}
		}
		hsp = 0;
		if (obj_player.state == states.punch || obj_player.state == states.parry)
		{
			alarm[3] = 3;
			global.hit += 1;
			if (other.object_index == obj_pizzaball)
			{
				global.golfhit += 1;
			}
			instance_create(x + (obj_player.xscale * 30), y, obj_bumpeffect);
			alarm[1] = 5;
			thrown = true;
			x = obj_player.x;
			vsp = 0;
			y = obj_player.y;
			state = states.stun;
			hsp = -image_xscale * 25;
			grav = 0;
			if (object_index != obj_swapplayergrabbable)
			{
				global.combotime = 60;
			}
						instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_baddiegibs);
			flash = true;
			with (obj_camera)
			{
				shake_mag = 3;
				shake_mag_acc = 3 / room_speed;
			}
		}
		if (obj_player.state == states.finishingblow)
		{
			if (floor(obj_player.image_index) < 1 && obj_player.sprite_index == obj_player.spr_swingdingend)
			{
				x = obj_player.x + (obj_player.xscale * 60);
				y = obj_player.y;
			}
			else if (floor(obj_player.image_index) < 4)
			{
				x = obj_player.x + (obj_player.xscale * 60);
				y = obj_player.y;
			}
			check_grabbed_solid(obj_player);
		}
		if (obj_player.state == states.backkick)
		{
			alarm[3] = 3;
			global.hit += 1;
			if (other.object_index == obj_pizzaball)
			{
				global.golfhit += 1;
			}
			hp -= 1;
			instance_create(x + (-obj_player.xscale * 50), y, obj_bumpeffect);
			alarm[1] = 5;
			thrown = true;
			x = obj_player.x;
			y = obj_player.y;
			state = states.stun;
			image_xscale *= -1;
			hsp = -image_xscale * 20;
			vsp = -7;
			if (object_index != obj_swapplayergrabbable)
			{
				global.combotime = 60;
			}
						instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_baddiegibs);
			flash = true;
			with (obj_camera)
			{
				shake_mag = 3;
				shake_mag_acc = 3 / room_speed;
			}
		}
		if (obj_player.state == states.finishingblow && (floor(obj_player.image_index) >= 4 || (floor(obj_player.image_index) < 1 && obj_player.sprite_index == obj_player.spr_swingdingend)))
		{
			thrown = true;
			var lag;
			if (heavy)
			{
				lag = 15;
			}
			else
			{
				lag = 5;
			}
			hitLag = lag;
			hitX = x;
			hitY = y;
			obj_player.movespeed = 0;
			obj_player.hitLag = lag;
			obj_player.hitX = obj_player.x;
			obj_player.hitY = obj_player.y;
			instance_create(x, y, obj_parryeffect);
			alarm[3] = 1;
			if (object_index != obj_swapplayergrabbable)
			{
				global.combotime = 60;
			}
						GamepadSetVibration((obj_player.object_index == obj_player) ? 0 : 1, 0.8, 0.8, 0.65);
			fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, y);
			fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y);
			if (!obj_player.ispeppino)
			{
				scr_fmod_soundeffect(obj_player.snd_noisepunch, x, y);
			}
			state = states.stun;
			image_xscale = -obj_player.xscale;
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_baddiegibs);
			instance_create(x, y, obj_baddiegibs);
			instance_create(x, y, obj_baddiegibs);
			with (obj_camera)
			{
				shake_mag = 3;
				shake_mag_acc = 3 / room_speed;
			}
			with (obj_player)
			{
				if (sprite_index == spr_uppercutfinishingblow)
				{
					other.hithsp = 0;
					other.hitvsp = -25;
					other.linethrown = true;
				}
				else
				{
					other.hithsp = -other.image_xscale * 25;
					other.hitvsp = -8;
					other.linethrown = true;
				}
				vsp = -6;
			}
			if (obj_player.sprite_index != spr_playerN_piledriver)
			{
				check_grabbed_solid(obj_player);
				check_grabbed_solid(obj_player);
			}
			hsp = hithsp;
			vsp = hitvsp;
			linethrown = true;
		}
		if (obj_player.state == states.throwing)
		{
			global.hit += 1;
			if (other.object_index == obj_pizzaball)
			{
				global.golfhit += 1;
			}
			alarm[1] = 5;
			thrown = true;
			x = obj_player.x;
			y = obj_player.y;
			state = states.stun;
			hsp = -image_xscale * 8;
			vsp = -6;
			check_grabbed_solid(obj_player);
			check_grabbed_solid(obj_player);
		}
		if (obj_player.state == states.uppunch)
		{
			alarm[3] = 3;
			global.hit += 1;
			if (other.object_index == obj_pizzaball)
			{
				global.golfhit += 1;
			}
			hp -= 1;
			instance_create(x + (-obj_player.xscale * 15), y - 50, obj_bumpeffect);
			alarm[1] = 5;
			thrown = true;
			x = obj_player.x;
			y = obj_player.y;
			hsp = -image_xscale * 2;
			state = states.stun;
			vsp = -20;
			if (object_index != obj_swapplayergrabbable)
			{
				global.combotime = 60;
			}
						instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_baddiegibs);
			flash = true;
			with (obj_camera)
			{
				shake_mag = 3;
				shake_mag_acc = 3 / room_speed;
			}
			check_grabbed_solid(obj_player);
		}
		if (obj_player.state == states.tacklecharge)
		{
			x = obj_player.x + (obj_player.xscale * 15);
			y = obj_player.y;
		}
		if (obj_player.state == states.superslam || (obj_player.state == states.chainsaw && sprite_index == spr_player_piledriver))
		{
			if (obj_player.ispeppino)
			{
				if (obj_player.sprite_index != obj_player.spr_piledriverland)
				{
					if (floor(obj_player.image_index) == 0)
					{
						depth = 0;
						x = obj_player.x + (obj_player.xscale * 10);
						y = obj_player.y;
					}
					if (floor(obj_player.image_index) == 1)
					{
						depth = 0;
						x = obj_player.x + (obj_player.xscale * 5);
						y = obj_player.y;
					}
					if (floor(obj_player.image_index) == 2)
					{
						depth = 0;
						x = obj_player.x;
						y = obj_player.y;
					}
					if (floor(obj_player.image_index) == 3)
					{
						depth = 0;
						x = obj_player.x + (obj_player.xscale * -5);
						y = obj_player.y;
					}
					if (floor(obj_player.image_index) == 4)
					{
						depth = 0;
						x = obj_player.x + (obj_player.xscale * -10);
						y = obj_player.y;
					}
					if (floor(obj_player.image_index) == 5)
					{
						depth = -8;
						x = obj_player.x + (obj_player.xscale * -5);
						y = obj_player.y;
					}
					if (floor(obj_player.image_index) == 6)
					{
						depth = -8;
						x = obj_player.x;
						y = obj_player.y;
					}
					if (floor(obj_player.image_index) == 7)
					{
						depth = -8;
						x = obj_player.x + (obj_player.xscale * 5);
						y = obj_player.y;
					}
					check_grabbed_solid(obj_player);
				}
				else
				{
					x = obj_player.x + (obj_player.xscale * 10);
					y = obj_player.y;
					check_grabbed_solid(obj_player);
				}
			}
			else
			{
				depth = -7;
				x = obj_player.x;
				y = obj_player.y - 54;
				if (obj_player.sprite_index == spr_playerN_piledriverland)
				{
					x = obj_player.x;
					y = obj_player.y + 4;
				}
			}
		}
		if (obj_player.sprite_index == obj_player.spr_piledriverland && floor(obj_player.image_index) == (obj_player.image_number - 1))
		{
			var lag = 5;
			hitLag = lag;
			obj_player.hitLag = lag;
			obj_player.hitX = obj_player.x;
			obj_player.hitY = obj_player.y;
			instance_create(obj_player.x, obj_player.y, obj_parryeffect);
			check_grabbed_solid(obj_player);
			hitX = x;
			hitY = y;
			alarm[3] = 3;
			if (!elite || elitehit <= 0)
			{
				mach3destroy = true;
			}
			state = states.hit;
			image_xscale = -obj_player.xscale;
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_baddiegibs);
			instance_create(x, y, obj_baddiegibs);
			instance_create(x, y, obj_baddiegibs);
			with (obj_camera)
			{
				shake_mag = 3;
				shake_mag_acc = 3 / room_speed;
			}
			with (obj_player)
			{
				if (state != states.chainsaw)
				{
					tauntstoredmovespeed = movespeed;
					tauntstoredsprite = sprite_index;
					tauntstoredstate = state;
					tauntstoredvsp = vsp;
				}
				state = states.chainsaw;
				other.hithsp = -other.image_xscale * 8;
				other.hitvsp = -11;
			}
		}
		if (obj_player.state == states.grab && obj_player.sprite_index == obj_player.spr_swingding)
		{
			if (floor(obj_player.image_index) == 0)
			{
				depth = -8;
				x = obj_player.x + (obj_player.xscale * 25);
				y = obj_player.y;
			}
			if (floor(obj_player.image_index) == 1)
			{
				depth = -8;
				x = obj_player.x;
				y = obj_player.y;
			}
			if (floor(obj_player.image_index) == 2)
			{
				depth = -8;
				x = obj_player.x + (obj_player.xscale * -25);
				y = obj_player.y;
			}
			if (floor(obj_player.image_index) == 3)
			{
				depth = 0;
				x = obj_player.x + (obj_player.xscale * -50);
				y = obj_player.y;
			}
			if (floor(obj_player.image_index) == 4)
			{
				depth = 0;
				x = obj_player.x + (obj_player.xscale * -25);
				y = obj_player.y;
			}
			if (floor(obj_player.image_index) == 5)
			{
				depth = 0;
				x = obj_player.x;
				y = obj_player.y;
			}
			if (floor(obj_player.image_index) == 6)
			{
				depth = 0;
				x = obj_player.x + (obj_player.xscale * 25);
				y = obj_player.y;
			}
			if (floor(obj_player.image_index) == 7)
			{
				depth = 0;
				x = obj_player.x + (obj_player.xscale * 50);
				y = obj_player.y;
			}
		}
		if (state != states.grabbed || obj_player.state != states.grab)
		{
			check_grabbed_solid(obj_player);
			if (state == states.hit)
			{
				hitX = x;
				hitY = y;
			}
		}
	}
	if (pepperman_grab)
	{
		var _player = obj_player.id;
		image_xscale = _player.xscale;
		if (!thrown)
		{
			x = _player.x;
			y = _player.y - 60;
		}
		if (_player.key_attack && !_player.key_up)
		{
			alarm[1] = 5;
			thrown = true;
			x = _player.x;
			y = _player.y - 10;
			state = states.stun;
			hsp = image_xscale * 30;
			vsp = -6;
			_player.sprite_index = spr_pepperman_throw;
			_player.image_index = 0;
		}
		if (_player.key_attack && _player.key_up)
		{
			alarm[1] = 5;
			thrown = true;
			x = _player.x;
			y = _player.y - 10;
			check_grabbed_solid(_player);
			state = states.stun;
			hsp = image_xscale * 2;
			vsp = -20;
			_player.sprite_index = spr_pepperman_throw;
			_player.image_index = 0;
		}
		if (_player.state != states.normal && _player.state != states.jump)
		{
			state = states.stun;
			pepperman_grab = false;
		}
	}
	sprite_index = stunfallspr;
	image_speed = 0.35;
}

function check_grabbed_solid(_inst)
{
	if (instakilled)
	{
		exit;
	}
	if (instance_exists(_inst) && _inst.sprite_index == spr_playerN_piledriver)
	{
		exit;
	}
	if (!place_meeting(x, y, obj_destructibles) && (scr_solid(x, y) || collision_line(x, y, _inst.x, _inst.y, obj_solid, false, true) != noone))
	{
		var _dist = abs(x - obj_player.x);
		x = _inst.x;
		y = _inst.y;
		if (!scr_solid(x + _inst.xscale, y))
		{
			var i = 0;
			while (!scr_solid(x + _inst.xscale, y))
			{
				x += _inst.xscale;
				i++;
				if (i > _dist)
				{
					break;
				}
			}
			if (scr_solid(x, y))
			{
				i = 0;
				while (scr_solid(x, y))
				{
					x -= _inst.xscale;
					i++;
					if (i > _dist)
					{
						break;
					}
				}
			}
		}
	}
}

function scr_enemy_hit()
{
	x = hitX + random_range(-6, 6);
	y = hitY + random_range(-6, 6);
	hitLag--;
	sprite_index = stunfallspr;
	if (object_index == obj_pepperman || object_index == obj_vigilanteboss || object_index == obj_noiseboss || object_index == obj_pf_fakepep || object_index == obj_fakepepboss || object_index == obj_pizzafaceboss || object_index == obj_pizzafaceboss_p3)
	{
		if (player_instakillmove && pizzahead && object_index != obj_gustavograbbable)
		{
			obj_player.baddiegrabbedID = id;
			scr_boss_grabbed();
			exit;
		}
	}
	if (hitLag <= 0)
	{
		x = hitX;
		y = hitY;
		var _player = noone;
		if (grabbedby == 1)
		{
			_player = obj_player.id;
		}
		var _state = obj_player.state;
		if (_state == states.chainsaw)
		{
			_state = obj_player.tauntstoredstate;
		}
		if ((object_index == obj_pepperman || object_index == obj_vigilanteboss || object_index == obj_noiseboss || object_index == obj_pf_fakepep || object_index == obj_fakepepboss || object_index == obj_pizzafaceboss || object_index == obj_pizzafaceboss_p3) && override_throw)
		{
			thrown = true;
			override_throw = false;
		}
		else if (_state == states.mach2 || _state == states.tumble || (_state == states.machslide && obj_player.sprite_index != obj_player.spr_mach3boost && obj_player.sprite_index != spr_player_machslideboost3fall) || sprite_index == spr_player_ratmountattack || sprite_index == spr_lonegustavo_dash)
		{
			thrown = false;
		}
		else
		{
			thrown = true;
		}
		vsp = hitvsp;
		hsp = hithsp;
		global.hit += 1;
		if (other.object_index == obj_pizzaball)
		{
			global.golfhit += 1;
		}
		if (thrown)
		{
			global.combotime = 60;
		}
		alarm[1] = 5;
		var _hp = 0;
		_hp = -1;
		if (((!elite && (hp <= _hp || mach3destroy)) || (elite && (elitehit <= 0 || mach3destroy))) && object_index != obj_pizzafaceboss && destroyable && !mach2)
		{
			instance_destroy();
			instance_create(x, y, obj_genericpoofeffect);
		}
		stunned = 200;
		state = states.stun;
		if (object_index == obj_pepperman || object_index == obj_vigilanteboss || object_index == obj_noiseboss || object_index == obj_pf_fakepep || object_index == obj_fakepepboss || object_index == obj_pizzafaceboss || object_index == obj_pizzafaceboss_p3)
		{
			if (obj_player.tauntstoredstate != states.punch && obj_player.tauntstoredstate != states.freefall && obj_player.tauntstoredstate != states.superslam)
			{
				linethrown = true;
				var f = 15;
				if (obj_player.tauntstoredstate == states.mach3)
				{
					f = 25;
				}
				if (abs(hithsp) > abs(hitvsp))
				{
					if (abs(hithsp) < f)
					{
						hithsp = sign(hithsp) * f;
					}
				}
				else if (abs(hitvsp) < f)
				{
					hitvsp = sign(hitvsp) * f;
				}
			}
			else if (!pizzahead)
			{
				hithsp = 22 * -image_xscale;
				hitvsp = -7;
				hsp = hithsp;
				vsp = hitvsp;
				flash = false;
				state = states.stun;
				thrown = true;
				linethrown = false;
			}
			if (_state == states.mach2 || _state == states.tumble)
			{
				stunned *= 5;
			}
		}
		if (mach2)
		{
			thrown = false;
		}
		mach2 = false;
	}
}

function scr_enemy_idle()
{
	hsp = 0;
	if (vsp > 1 && (grounded || (grounded && !place_meeting(x, y, obj_platform))))
	{
		create_particle(x, y, particletypes.landcloud, 0);
		image_index = 0;
	}
	if ((vsp >= 0 || object_index == obj_miniufo || object_index == obj_kentukybomber) && sprite_index == scaredspr && scaredbuffer <= 0)
	{
		state = states.walk;
		sprite_index = walkspr;
		if (object_index == obj_treasureguy)
		{
			state = states.chase;
		}
		if (object_index == obj_pickle && attacking)
		{
			attacking = false;
			bombreset = 0;
		}
	}
	if (scaredbuffer > 0)
	{
		scaredbuffer--;
	}
	if (sprite_index == spr_tank_spawnenemy && ANIMATION_END)
	{
		sprite_index = walkspr;
		state = states.walk;
	}
	if (sprite_index == spr_forknight_turn && ANIMATION_END)
	{
		sprite_index = walkspr;
		state = states.walk;
	}
	if (sprite_index == spr_patroller_turn && ANIMATION_END)
	{
		sprite_index = walkspr;
		state = states.walk;
	}
	if (sprite_index == spr_newpizzice_turn && ANIMATION_END)
	{
		image_xscale *= -1;
		sprite_index = walkspr;
		state = states.charge;
	}
	if (sprite_index == spr_ghostknight_turn && ANIMATION_END)
	{
		sprite_index = walkspr;
		state = states.walk;
	}
	if (sprite_index == spr_pizzaslug_turn && ANIMATION_END)
	{
		sprite_index = walkspr;
		image_xscale *= -1;
		state = states.walk;
	}
	if (sprite_index == spr_indiancheese_turn && ANIMATION_END)
	{
		sprite_index = walkspr;
		state = states.walk;
	}
	if (sprite_index == spr_tank_turn && ANIMATION_END)
	{
		sprite_index = walkspr;
		state = states.walk;
	}
	if (place_meeting(x, y + 1, obj_railparent))
	{
		var _railinst = instance_place(x, y + 1, obj_railparent);
		hsp += (_railinst.movespeed * _railinst.dir);
	}
	image_speed = 0.35;
}

function scr_enemy_lungeattack()
{
	hsp = -image_xscale * 4;
	vsp = 0;
	var _l = false;
	with (obj_player)
	{
		if (state == states.lungeattack && image_index <= 4)
		{
			_l = true;
		}
	}
	if (!_l)
	{
		hitLag = 0;
	}
	if (hitLag > 0)
	{
		hitLag--;
	}
	else
	{
		state = states.stun;
		hsp = hithsp;
		vsp = hitvsp;
		stunned = 200;
	}
}

function scr_enemy_pizzaheadjump()
{
	stompable = false;
	if (place_meeting(x, y, obj_solid))
	{
		vsp = -12;
	}
	if (vsp < 0)
	{
		use_collision = false;
		x += hsp;
		y += vsp;
		if (vsp < 20)
		{
			vsp += grav;
		}
	}
	else
	{
		use_collision = true;
	}
	sprite_index = stunfallspr;
	if (grounded && vsp > 0)
	{
		stompable = true;
		state = states.stun;
		stunned = 2;
	}
}

function scr_enemy_rage()
{
	switch (object_index)
	{
		case obj_forknight:
			image_speed = 0.6;
			if (sprite_index == spr_forknight_ragestart)
			{
				hsp = 0;
				if (image_index > (image_number - 1))
				{
					sprite_index = spr_forknight_rageloop;
					image_index = 0;
				}
			}
			else if (sprite_index == spr_forknight_rageloop)
			{
				hsp = image_xscale * (4 + (global.baddiespeed - 1));
				with (instance_place(x + hsp, y, obj_destructibles))
				{
					instance_destroy();
				}
				if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_destructibles) && !place_meeting(x + hsp, y, obj_slope))
				{
					state = states.stun;
					stunned = 100;
					vsp = -8;
					hsp = -image_xscale * 5;
				}
			}
			break;
		case obj_soldier:
			hsp = 0;
			if (!hitboxcreate)
			{
				hitboxcreate = true;
				with (instance_create(x, y, obj_forkhitbox))
				{
					image_xscale = other.image_xscale;
					ID = other.id;
				}
			}
			if (ANIMATION_END)
			{
				ragebuffer = 100;
				state = states.walk;
				sprite_index = walkspr;
			}
			break;
		case obj_smokingpizzaslice:
			if (floor(image_index) == 12 && !shot)
			{
				with (instance_create(x + (image_xscale * 70), y + 8, obj_parryeffect))
				{
					sprite_index = spr_player_pistoleffect;
					image_xscale = other.image_xscale;
					image_speed = 0.4;
				}
				fmod_event_one_shot_3d("event:/sfx/enemies/rancherpistol", x, y);
				shot = true;
				with (instance_create(x + (image_xscale * 15), y + 5, obj_slugbullet))
				{
					image_xscale = other.image_xscale;
				}
			}
			if (ANIMATION_END)
			{
				shot = false;
				sprite_index = spr_pizzaslug_walk;
				state = states.walk;
				ragecooldown = 100;
			}
			break;
		case obj_indiancheese:
			ragedash--;
			if (ragedash == 0)
			{
				ragecooldown = 200;
				ragedash = 50;
				state = states.walk;
				sprite_index = walkspr;
			}
			if (!shot && ragedash < 30)
			{
				fmod_event_one_shot_3d("event:/sfx/enemies/projectile", x, y);
				shot = true;
				with (instance_create(x, y, obj_arcprojectile))
				{
					image_xscale = other.image_xscale;
					hsp = image_xscale * 6;
					vsp = -11;
				}
			}
			break;
		case obj_miniufo:
			if (floor(image_index) == 3 && !shoot)
			{
				shoot = true;
				instance_create(x, y, obj_warplaserhoming);
			}
			if (ANIMATION_END)
			{
				state = states.walk;
			}
			break;
		case obj_cheeseslime:
			if (floor(image_index) > 10)
			{
				hsp = image_xscale * 8;
				with (instance_create(x, y, obj_baddieragehitbox))
				{
					ID = other.id;
					image_xscale = other.image_xscale;
				}
			}
			else
			{
				hsp = 0;
			}
			if (ANIMATION_END)
			{
				state = states.walk;
				sprite_index = walkspr;
			}
			break;
		case obj_minijohn:
			hsp = movespeed * image_xscale;
			if (sprite_index == spr_minijohn_rage1 && ANIMATION_END)
			{
				sprite_index = spr_minijohn_rage2;
			}
			if (grounded && vsp > 0)
			{
				var targetplayer = obj_player;
				movespeed = 4;
				image_xscale = -sign(x - targetplayer.x);
				state = states.chase;
				sprite_index = spr_minijohn_charge;
			}
			break;
		case obj_fencer:
			var thespeed = 0;
			if (image_index > 7)
			{
				thespeed = 12;
			}
			hsp = image_xscale * thespeed;
			if (ANIMATION_END)
			{
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
			break;
		case obj_ancho:
			hsp = 0;
			if (sprite_index == spr_ancho_rage1)
			{
				vsp = 0;
			}
			if (sprite_index == spr_ancho_rage2)
			{
				vsp = 10;
			}
			if (ANIMATION_END && sprite_index == spr_ancho_rage1)
			{
				sprite_index = spr_ancho_rage2;
			}
			if (grounded && sprite_index == spr_ancho_rage2)
			{
				with (obj_camera)
				{
					shake_mag = 10;
					shake_mag_acc = 30 / room_speed;
				}
				image_index = 0;
				sprite_index = spr_ancho_rage3;
			}
			if (ANIMATION_END && sprite_index == spr_ancho_rage3)
			{
				state = states.walk;
				sprite_index = spr_ancho;
			}
			break;
		case obj_spitcheese:
			break;
		case obj_tank:
			if (sprite_index != spr_tank_chargestart)
			{
				if ((x + hsp) == xprevious)
				{
					slope_buffer--;
				}
				else
				{
					slope_buffer = 12;
				}
			}
			if (sprite_index == spr_tank_chargestart)
			{
				hsp = 0;
			}
			if (sprite_index == spr_tank_charge)
			{
				hsp = image_xscale * 8;
			}
			if (ANIMATION_END && sprite_index == spr_tank_chargestart)
			{
				sprite_index = spr_tank_charge;
			}
			with (instance_place(x + hsp, y, obj_destructibles))
			{
				instance_destroy();
			}
			if ((place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_destructibles) && !scr_slope()) || slope_buffer <= 0)
			{
				slope_buffer = 8;
				state = states.stun;
				hsp = -image_xscale * 7;
				vsp = -6;
				sprite_index = spr_tank_hitwall;
				stunned = 200;
				bombreset = 200;
			}
			break;
		case obj_thug_red:
			if (!shot && floor(image_index) == 9)
			{
				shot = true;
				with (instance_create(x + (8 * image_xscale), y, obj_robotknife))
				{
					image_xscale = other.image_xscale;
					hsp = other.image_xscale * 5;
				}
			}
			if (ANIMATION_END)
			{
				ragecooldown = 100;
				state = states.walk;
			}
			break;
	}
	if (place_meeting(x, y + 1, obj_railparent))
	{
		var _railinst = instance_place(x, y + 1, obj_railparent);
		hsp += (_railinst.movespeed * _railinst.dir);
	}
}

function scr_enemy_secret()
{
	visible = false;
	invincible = true;
	hsp = 0;
	if (!secretjumped && !place_meeting(x, y, obj_secretbigblock))
	{
		secretjumped = true;
		vsp = -8;
	}
	if (secretjumped)
	{
		visible = true;
		if (grounded && vsp > 0)
		{
			invincible = savedsecretinvincible;
			state = states.walk;
			sprite_index = walkspr;
		}
	}
}

function scr_enemy_stun()
{
	if (object_index == obj_ninja)
	{
		attack = true;
	}
	stunned -= 1;
	if (stuntouchbuffer > 0)
	{
		stuntouchbuffer--;
	}
	var t = thrown;
	if (object_index != obj_pepperman && object_index != obj_fakepepboss && object_index != obj_pf_fakepep)
	{
		if (sprite_index != spr_tank_hitwall)
		{
			if (!thrown)
			{
				sprite_index = stunfallspr;
			}
			else
			{
				sprite_index = spr_dead;
			}
		}
		else if (ANIMATION_END && sprite_index == spr_tank_hitwall)
		{
			state = states.walk;
			stunned = 0;
			sprite_index = spr_tank_walk;
		}
	}
	else if (object_index == obj_pepperman)
	{
		if (thrown)
		{
			sprite_index = spr_dead;
		}
		else if (sprite_index != spr_pepperman_shoulderhurt && sprite_index != spr_pepperman_shoulderhurtstart)
		{
			sprite_index = stunfallspr;
		}
		if (sprite_index == spr_pepperman_shoulderhurtstart && ANIMATION_END)
		{
			sprite_index = spr_pepperman_shoulderhurt;
		}
	}
	else if (object_index == obj_fakepepboss || object_index == obj_pf_fakepep)
	{
		if (!thrown)
		{
			if (sprite_index != spr_fakepeppino_vulnerable)
			{
				sprite_index = stunfallspr;
			}
		}
		else
		{
			sprite_index = spr_dead;
		}
	}
	image_speed = 0.35;
	if (linethrown)
	{
		if (thrown)
		{
			if (abs(hithsp) > abs(hitvsp))
			{
				hitvsp = 0;
			}
			hsp = hithsp;
			vsp = hitvsp;
			if (hithsp != 0)
			{
				scr_destroy_destructibles(hithsp, 0);
			}
			if (hitvsp != 0)
			{
				scr_destroy_destructibles(0, hitvsp);
			}
		}
	}
	if (hitvsp < 0 && place_meeting(x, y - 1, obj_solid) && !place_meeting(x, y - 1, obj_destructibles))
	{
		if (thrown)
		{
			if ((!elite || elitehit <= 0) && elitehurt && destroyable)
			{
				instance_destroy();
			}
			thrown = false;
		}
	}
	if (hithsp != 0 && place_meeting(x + hithsp, y, obj_solid) && !place_meeting(x + hithsp, y, obj_destructibles))
	{
		if (thrown)
		{
			if ((!elite || elitehit <= 0) && elitehurt && destroyable)
			{
				instance_destroy();
			}
			thrown = false;
		}
	}
	if (blur_effect > 0)
	{
		blur_effect--;
	}
	else if (thrown)
	{
		blur_effect = 2;
		with (create_blur_afterimage(x, y, sprite_index, image_index - 1, image_xscale))
		{
			playerid = other.id;
		}
	}
	if (grounded && vsp > 0 && thrown)
	{
		if ((!elite || elitehit <= 0) && elitehurt && destroyable)
		{
			instance_destroy();
		}
		thrown = false;
	}
	if (t != thrown && t && elite)
	{
		elitehit--;
		if (elitehit < 0)
		{
			elitehit = 0;
		}
		if (elitehit > 0 || !destroyable)
		{
			event_perform(ev_destroy, 0);
			var b = ds_list_find_index(global.baddieroom, id);
			if (b != -1)
			{
				ds_list_delete(global.baddieroom, b);
			}
			image_xscale *= -1;
			hsp = 5 * -image_xscale;
			if (object_index == obj_pizzafaceboss)
			{
				x += (sign(hsp) * 30);
			}
			flash = false;
		}
		else if (elitehit <= 0 && destroyable)
		{
			instance_destroy();
		}
	}
	if (grounded && elite)
	{
		stunned -= 5;
	}
	if (stunned <= 0 && grounded)
	{
		vsp = 0;
		image_index = 0;
		sprite_index = walkspr;
		state = states.walk;
		stunned = 0;
		if (object_index == obj_golfdemon && !idle)
		{
			state = states.chase;
			movespeed = 6;
		}
	}
	if (place_meeting(x, y + 1, obj_railparent))
	{
		var _railinst = instance_place(x, y + 1, obj_railparent);
		railmovespeed = _railinst.movespeed * _railinst.dir;
		if (grounded && !thrown)
		{
			hsp = railmovespeed;
		}
	}
	else
	{
		railmovespeed = Approach(railmovespeed, 0, 0.5);
		if (grounded)
		{
			hsp = Approach(hsp, 0, 0.3);
		}
	}
	if (!thrown)
	{
		grav = 0.5;
	}
	if (abs(hsp) > 4 && grounded)
	{
		if (!instance_exists(dashcloudid))
		{
			with (instance_create(x, y, obj_dashcloud))
			{
				image_xscale = sign(other.hsp);
				other.dashcloudid = id;
			}
		}
	}
}

function scr_enemy_walk()
{
	if (object_index != obj_robot && object_index != obj_pizzice && object_index != obj_spitcheese && object_index != obj_ninja && object_index != obj_camerapatrol && object_index != obj_trash && object_index != obj_fencer && object_index != obj_rancher && object_index != obj_banditochicken && object_index != obj_ancho && object_index != obj_pickle && object_index != obj_thug_red)
	{
		hsp = (image_xscale * movespeed) + railmovespeed;
	}
	else if (object_index == obj_robot)
	{
		hsp = railmovespeed;
	}
	else if (object_index == obj_pickle)
	{
		if (!walked)
		{
			hsp += (accel * sign(image_xscale));
			if (hsp < -movespeed || hsp > movespeed)
			{
				hsp = movespeed * sign(image_xscale);
				walked = true;
			}
		}
		else
		{
			hsp -= (deccel * sign(image_xscale));
			if (hsp > -deccel_threshold && hsp < deccel_threshold)
			{
				walked = false;
			}
		}
	}
	else if (object_index != obj_ninja && object_index != obj_banditochicken && object_index != obj_thug_red)
	{
		hsp = 0;
	}
	if (place_meeting(x, y + 1, obj_railparent))
	{
		var _railinst = instance_place(x, y + 1, obj_railparent);
		railmovespeed = _railinst.movespeed * _railinst.dir;
	}
	else
	{
		railmovespeed = 0;
	}
	if (!grounded && object_index != obj_clownmato && object_index != obj_pizzaball && object_index != obj_camerapatrol && object_index != obj_noisey && object_index != obj_ancho && object_index != obj_miniufo && object_index != obj_kentukybomber && object_index != obj_clownmato)
	{
		hsp = 0;
	}
	if (turntimer > 0 && turner)
	{
		turntimer--;
	}
	if ((scr_solid(x + image_xscale, y) || place_meeting(x + hsp, y, obj_hallway) || (x + hsp) > (room_width + 50) || (x + hsp) < -50) || (turntimer <= 0 && turner))
	{
		if (!place_meeting(x + sign(hsp), y, obj_slope))
		{
			if (object_index == obj_forknight)
			{
				image_xscale *= -1;
				image_index = 0;
				sprite_index = spr_forknight_turn;
				state = states.idle;
			}
			else if (object_index == obj_snowman)
			{
				image_xscale *= -1;
				image_index = 0;
				sprite_index = spr_newpizzice_turn;
				state = states.idle;
			}
			else if (object_index == obj_patroller)
			{
				if (!patrolfound)
				{
					image_xscale *= -1;
					image_index = 0;
					sprite_index = spr_patroller_turn;
					state = states.idle;
				}
			}
			else if (object_index == obj_tank)
			{
				image_xscale *= -1;
				image_index = 0;
				sprite_index = spr_tank_turn;
				state = states.idle;
			}
			else if (object_index == obj_ghostknight)
			{
				image_xscale *= -1;
				image_index = 0;
				sprite_index = spr_ghostknight_turn;
				state = states.idle;
			}
			else
			{
				if (!turnstart)
				{
					turnstart = true;
				}
				else
				{
					image_xscale *= -1;
				}
				if (object_index == obj_pickle)
				{
					hsp = 0;
				}
				if (object_index == obj_miniufo || object_index == obj_kentukybomber)
				{
					turntimer = turnmax;
				}
			}
			turntimer = turnmax;
		}
	}
	if (object_index != obj_ancho && object_index != obj_camerapatrol)
	{
		if (!(scr_solid(x + (image_xscale * 15), y + 31) || place_meeting(x + (image_xscale * 15), y + 31, obj_platform)) || (x + hsp) > (room_width + 50) || (x + hsp) < -50)
		{
			if (movespeed > 0 && grounded)
			{
				if (!(object_index == obj_ninja)) if (object_index == obj_forknight)
				{
					image_xscale *= -1;
					image_index = 0;
					sprite_index = spr_forknight_turn;
					state = states.idle;
				}
				else if (object_index == obj_snowman)
				{
					image_xscale *= -1;
					image_index = 0;
					sprite_index = spr_newpizzice_turn;
					state = states.idle;
				}
				else if (object_index == obj_patroller)
				{
					if (!patrolfound)
					{
						image_xscale *= -1;
						image_index = 0;
						sprite_index = spr_patroller_turn;
						state = states.idle;
					}
				}
				else if (object_index == obj_indiancheese)
				{
					image_xscale *= -1;
					image_index = 0;
					sprite_index = spr_indiancheese_turn;
					state = states.idle;
				}
				else if (object_index == obj_ghostknight)
				{
					image_xscale *= -1;
					image_index = 0;
					sprite_index = spr_ghostknight_turn;
					state = states.idle;
				}
				else if (object_index == obj_tank)
				{
					image_xscale *= -1;
					image_index = 0;
					sprite_index = spr_tank_turn;
					state = states.idle;
				}
				else
				{
					image_xscale *= -1;
					if (object_index == obj_pickle)
					{
						hsp = 0;
					}
				}
				turntimer = turnmax;
			}
		}
	}
}

function scr_enemy_staggered()
{
	sprite_index = stunfallspr;
	if (stuntouchbuffer > 0)
	{
		stuntouchbuffer--;
	}
	if (stagger_buffer > 0)
	{
		hsp = 0;
		stagger_buffer--;
	}
	else if (stagger_buffer == 0)
	{
		vsp = -stagger_jumpspeed;
		hsp = stagger_dir * stagger_movespeed;
		stagger_buffer = -1;
	}
	else if (ANIMATION_END && grounded)
	{
		image_index = 0;
		sprite_index = walkspr;
		state = states.walk;
	}
}
