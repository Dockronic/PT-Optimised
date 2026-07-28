function textures_offload(_texgroups)
{
	var b = instance_create(0, 0, obj_loadingscreen);
	with (b)
	{
		group_arr = _texgroups;
		if (global.offload_tex != noone)
		{
			offload_arr = array_create(0);
			array_copy(offload_arr, 0, global.offload_tex, 0, array_length(global.offload_tex));
			global.offload_tex = noone;
		}
	}
	return b;
}

function scr_playerreset(_stop_music = true)
{
	trace("playerreset");
	global.lap = false;
	if (room != boss_pizzaface && room != boss_noise && room != boss_pepperman && room != boss_fakepep && room != boss_vigilante)
	{
		global.bossintro = false;
	}
	global.bossplayerhurt = false;
	global.swap_boss_damage = 0;
	global.playerhit = 0;
	global.laps = 0;
	global.secretfound = 0;
	global.combo = 0;
	global.highest_combo = 0;
	global.player_damage = 0;
	global.swap_damage[0] = 0;
	global.swap_damage[1] = 0;
	global.peppino_damage = 0;
	global.gustavo_damage = 0;
	global.comboscore = 0;
	global.enemykilled = 0;
	global.tauntcount = 0;
	global.prank_enemykilled = false;
	global.prank_cankillenemy = true;
	global.noisejetpack = false;
	with (obj_player)
	{
		noisepizzapepper = false;
	}
	global.level_minutes = 0;
	global.level_seconds = 0;
	global.pistol = false;
	with (obj_screensizer)
	{
		camzoom = 1;
	}
	with (obj_camera)
	{
		camzoom = 1;
		lock = false;
		state = states.normal;
	}
	with (obj_swapmodefollow)
	{
		isgustavo = false;
		get_character_spr();
	}
	with (obj_achievementtracker)
	{
		achievement_reset_variables(achievements_notify);
		achievement_reset_variables(achievements_update);
	}
	if (_stop_music)
	{
		with (obj_music)
		{
			secretend = true;
			secret = false;
			exitmusic = false;
		}
		stop_music();
	}
	fmod_set_parameter("musicmuffle", 0, true);
	fmod_set_parameter("pillarfade", 0, true);
	camera_set_view_size(view_camera[0], SCREEN_WIDTH, SCREEN_HEIGHT);
	instance_destroy(obj_frontcanongoblin);
	instance_destroy(obj_pumpkineffect);
	instance_destroy(obj_pumpkincounter);
	instance_destroy(obj_transfotip);
	instance_destroy(obj_flushcount);
	instance_destroy(obj_fadeout);
	instance_destroy(obj_comboend);
	instance_destroy(obj_combotitle);
	instance_destroy(obj_confettieffect);
	instance_destroy(obj_pizzaball_rank);
	instance_destroy(obj_pizzaball_golfhit);
	instance_destroy(obj_combotitle);
	instance_destroy(obj_comboend);
	instance_destroy(obj_sandparticle);
	instance_destroy(obj_lap2visual);
	instance_destroy(obj_keyfollow);
	instance_destroy(obj_hpeffect);
	instance_destroy(obj_crosspriest_cross);
	instance_destroy(obj_gravecorpse, false);
	with (obj_camera)
	{
		alarm[4] = -1;
		comboend = false;
		previousrank = 0;
	}
	if (!global.levelreset)
	{
		instance_destroy(obj_surfback);
		instance_destroy(obj_randomsecret);
		instance_destroy(obj_deliverytimer);
		instance_destroy(obj_wartimer);
		with (obj_cutscene_handler)
		{
			instance_destroy();
		}
		with (obj_snowparticle)
		{
			instance_destroy();
		}
		with (obj_camera)
		{
			alarm[4] = -1;
		}
		with (obj_tv)
		{
			tv_bg_index = 0;
			expressionsprite = noone;
			if (!global.levelreset)
			{
				sprite_index = spr_tv_off;
				state = states.normal;
				tv_set_idle();
			}
		}
		with (obj_secretmanager)
		{
			ds_list_clear(secrettriggers);
			ds_list_clear(touchall);
			init = false;
		}
		ds_list_clear(global.baddieroom);
		ds_list_clear(global.saveroom);
		ds_list_clear(global.escaperoom);
		global.combodropped = false;
		global.secretfound = 0;
		global.hurtcounter = 0;
		global.pizzadelivery = false;
		global.failcutscene = false;
		global.pizzasdelivered = 0;
		global.spaceblockswitch = true;
		global.fill = 500;
		global.hasfarmer = array_create(3, false);
		global.gerome = false;
		global.mort = false;
		global.spaceblockswitch = true;
		global.baddiespeed = 1;
		global.horse = false;
		global.golfhit = 0;
		global.railspeed = global.maxrailspeed;
		global.timedgate = false;
		global.timedgatetimer = false;
		global.timedgateid = noone;
		global.timedgatetime = 0;
		global.key_inv = false;
		global.shroomfollow = false;
		global.cheesefollow = false;
		global.tomatofollow = false;
		global.sausagefollow = false;
		global.pineapplefollow = false;
		global.keyget = false;
		global.collect = 0;
		global.lastcollect = 0;
		global.collect_player[0] = 0;
		global.collect_player[1] = 0;
		global.hats = 0;
		global.extrahats = 0;
		global.ammo = 0;
		global.treasure = false;
		global.combo = 0;
		global.combotime = 0;
		global.toppintotal = 1;
		global.hit = 0;
		global.playerhealth = 100;
		global.panic = false;
		if (instance_exists(obj_endlevelfade))
		{
			instance_destroy(obj_endlevelfade);
		}
		instance_destroy(obj_trapghost);
		instance_destroy(obj_comboend);
		with (obj_pizzaface)
		{
			destroy_sounds([snd]);
		}
		instance_destroy(obj_pizzaface, false);
		if (instance_exists(obj_timesup))
		{
			instance_destroy(obj_timesup);
		}
	}
	with (obj_player)
	{
		mort = false;
		noisepizzapepper = false;
		goblinkey = false;
		transformationsnd = false;
		fmod_event_instance_release(snd_voiceok);
		snd_voiceok = fmod_event_create_instance("event:/sfx/voice/ok");
		image_alpha = 1;
		hallway = false;
		verticalhallway = false;
		tauntstoredstate = states.normal;
		ratpowerup = noone;
		scale_xs = 1;
		scale_ys = 1;
		holycross = 0;
		ghostdash = false;
		ghostdashbuffer = 0;
		ghostpepper = 0;
		ghosteffect = 0;
		ghostbump = 1;
		ghostbumpbuffer = -1;
		obj_camera.targetgolf = noone;
		obj_player.supercharge = 0;
		obj_player.supercharged = false;
		pistol = false;
		audio_stop_all();
		global.seconds = 59;
		global.minutes = 1;
		obj_player.prevstate = states.comingoutdoor;
		obj_player.state = states.comingoutdoor;
		obj_player.visible = true;
		ds_list_clear(global.saveroom);
		ds_list_clear(global.escaperoom);
		ds_list_clear(global.baddieroom);
		with (obj_player)
		{
			flash = false;
			pistolcharge = 0;
			pistolchargeshooting = false;
			pistolchargeshot = 8;
			ds_list_clear(hitlist);
			pistolanim = noone;
			image_blend = make_colour_hsv(0, 0, 255);
			boxxed = false;
			boxxeddash = false;
			supercharged = false;
			pizzapepper = 0;
			c = c_black;
			heavy = false;
			image_index = 0;
			sprite_index = spr_walkfront;
			alarm[0] = -1;
			alarm[1] = -1;
			alarm[3] = -1;
			alarm[4] = -1;
			alarm[5] = -1;
			alarm[6] = -1;
			alarm[7] = -1;
			alarm[8] = -1;
			alarm[9] = -1;
			alarm[10] = -1;
			grav = 0.5;
			hsp = 0;
			vsp = 0;
			xscale = 1;
			yscale = 1;
			parry = false;
			parry_inst = noone;
			parry_count = 0;
			x = backtohubstartx;
			y = backtohubstarty;
			roomstartx = x;
			roomstarty = y;
			shotgunAnim = false;
			box = false;
			steppy = false;
			jumpstop = false;
			obj_camera.ded = false;
			visible = true;
			turn = false;
			jumpAnim = true;
			landAnim = false;
			machslideAnim = false;
			crouchAnim = true;
			stompAnim = false;
			inv_frames = false;
			hurted = false;
			mach2 = 0;
			input_buffer_jump = 0;
			input_buffer_secondjump = 8;
			input_buffer_highjump = 8;
			flash = false;
			key_particles = false;
			barrel = false;
			bounce = false;
			a = 0;
			idle = 0;
			attacking = false;
			superslam = 0;
			machpunchAnim = false;
			punch = false;
			machfreefall = 0;
			shoot = false;
			instakillmove = false;
			windingAnim = 0;
			ladderbuffer = 0;
			chainsaw = 50;
			toomuchalarm1 = 0;
			idleanim = 0;
			momemtum = false;
			cutscene = false;
			grabbing = false;
			dir = xscale;
			fallinganimation = 0;
			bombpeptimer = 100;
			anger = 0;
			angry = false;
			skateboarding = false;
			brick = false;
			isgustavo = false;
			noisecrusher = false;
			tauntstoredisgustavo = false;
			noisebossscream = false;
		}
	}
	with (obj_followcharacter)
	{
		if (persistent && object_index != obj_swapmodefollow)
		{
			instance_destroy();
		}
	}
}
