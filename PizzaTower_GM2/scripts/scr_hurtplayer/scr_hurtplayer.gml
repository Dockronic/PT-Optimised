function scr_hurtplayer(_player)
{
	var _obj = object_index;
	var _savedstate = _player.state;
	var _hurt = false;
	var _swap = false;
	with (_player)
	{
		if (!(global.failcutscene || instance_exists(obj_endlevelfade) || state == states.ratmounthurt || state == states.duel || state == states.supergrab || state == states.phase2transition || state == states.parry || instance_exists(obj_vigilante_duelintro) || state == states.taxi || state == states.spaceshuttle || state == states.tube || state == states.debugstate || state == states.golf || state == states.slipbanan || (global.noisejetpack && (ispeppino || noisepizzapepper)) || holycross > 0 || invtime > 0 || sprite_index == spr_jetpackstart2)) if ((state == states.backbreaker && (parrytimer > 0 || instance_exists(obj_parryhitbox) || sprite_index == spr_supertaunt1 || sprite_index == spr_supertaunt2 || sprite_index == spr_supertaunt3 || sprite_index == spr_supertaunt4 || sprite_index == spr_player_ratmountsupertaunt)) || state == states.chainsaw || state == states.phase1hurt || state == states.actor || instance_exists(obj_bossdark))
		{
			if (state == states.backbreaker)
			{
				trace(parrytimer);
			}
		}
		else if (isgustavo)
		{
			if (!hurted)
			{
				if (x != other.x)
				{
					xscale = sign(other.x - x);
				}
				if (irandom(100) <= 50)
				{
					fmod_event_one_shot_3d("event:/sfx/voice/gushurt", x, y);
				}
				state = states.ratmounthurt;
				movespeed = 6;
				vsp = -9;
				flash = true;
				fmod_event_one_shot_3d("event:/sfx/pep/hurt", x, y);
				alarm[8] = 100;
				alarm[5] = 2;
				alarm[7] = 150;
				hurted = true;
				instance_create(x, y, obj_spikehurteffect);
				_hurt = true;
				_swap = swap_player(true);
			}
		}
		else if ((instance_exists(obj_pizzafaceboss) && obj_pizzafaceboss.state == states.transitioncutscene) || (instance_exists(obj_pizzafaceboss_p2) && obj_pizzafaceboss_p2.state == states.fall) || state == states.shotgundash || ((state == states.knightpep || state == states.knightpepattack || state == states.knightpepslopes || state == states.knightpepbump) && !cutscene) || state == states.ghost || state == states.slipnslide || state == states.trickjump || state == states.chainsaw || state == states.chainsawbump || (state == states.bombpep && !hurted) || state == states.rideweenie)
		{
		}
		else if (state != states.hurt && state != states.ratmounthurt && state != states.grabbed && (!hurted || state == states.cheesepep || state == states.cheesepepstickside || state == states.cheesepepstickup) && !cutscene)
		{
			if (state == states.animatronic)
			{
				with (instance_create(x, y, obj_peshinodebris))
				{
					image_index = 0;
				}
				with (instance_create(x, y, obj_peshinodebris))
				{
					image_index = 1;
				}
				with (instance_create(x, y, obj_peshinodebris))
				{
					image_index = 2;
				}
			}
			if (state == states.barrel || state == states.barrelclimbwall || state == states.barreljump || state == states.barrelslide)
			{
				repeat (4)
				{
					create_debris(x, y, spr_barreldebris);
				}
			}
			var _old_xscale = xscale;
			if (x != other.x)
			{
				xscale = sign(other.x - x);
			}
			if (state == states.mort || state == states.morthook || state == states.mortjump || state == states.mortattack)
			{
				fmod_event_one_shot_3d("event:/sfx/mort/mortdead", x, y);
				create_debris(x, y - 40, spr_mortdead);
			}
			_hurt = true;
			pistolanim = noone;
			if (state == states.trashroll || state == states.trashjump)
			{
				create_debris(x, y, spr_player_trashlid);
			}
			scr_sleep(100);
			fmod_event_one_shot_3d("event:/sfx/pep/hurt", x, y);
			if (irandom(100) <= 50)
			{
				fmod_event_instance_play(snd_voicehurt);
			}
			instance_create(x, y, obj_bangeffect);
			alarm[8] = 100;
			alarm[7] = 150;
			hurted = true;
			if (xscale == -_old_xscale)
			{
				sprite_index = spr_hurtjump;
			}
			else
			{
				sprite_index = spr_hurt;
			}
			movespeed = 8;
			vsp = -14;
			pistolanim = noone;
			instance_create(x, y, obj_spikehurteffect);
			state = states.hurt;
			image_index = 0;
			flash = true;
			_swap = swap_player(true);
			if (_swap)
			{
				alarm[5] = 2;
				alarm[7] = 80;
				hurted = true;
			}
			repeat (5)
			{
				instance_create(x, y, obj_hurtstars);
			}
		}
		if (_hurt)
		{
			notification_push(notifications.hurt, [_player.id, _savedstate, _obj]);
			global.combotime -= 25;
			global.hurtcounter += 1;
			global.player_damage += 1;
			if (global.swapmode)
			{
				global.swap_boss_damage++;
			}
			global.swap_damage[player_index]++;
			if (!isgustavo)
			{
				global.peppino_damage += 1;
			}
			else if (!_swap)
			{
				global.gustavo_damage += 1;
			}
			var damage_n = global.peppino_damage;
			if (isgustavo)
			{
				damage_n = global.gustavo_damage;
			}
			if (global.swapmode)
			{
				damage_n = global.swap_damage[player_index];
				if (_swap && noisecrusher)
				{
					global.gustavo_damage += 1;
					damage_n = global.gustavo_damage;
				}
			}
			var hurtTV = spr_tv_exprhurt1;
			if (!_swap)
			{
				if (!isgustavo)
				{
					tv_do_expression(spr_tv_exprhurt);
				}
				else
				{
					tv_do_expression(spr_tv_hurtG);
				}
				if (ispeppino)
				{
					hurtTV = choose(spr_tv_exprhurt1, spr_tv_exprhurt2, spr_tv_exprhurt3, spr_tv_exprhurt4, spr_tv_exprhurt5, spr_tv_exprhurt6, spr_tv_exprhurt7, spr_tv_exprhurt8, spr_tv_exprhurt9, spr_tv_exprhurt10);
				}
				else
				{
					hurtTV = choose(spr_tv_exprhurtN1, spr_tv_exprhurtN2, spr_tv_exprhurtN3, spr_tv_exprhurtN4, spr_tv_exprhurtN5, spr_tv_exprhurtN6, spr_tv_exprhurtN7, spr_tv_exprhurtN8, spr_tv_exprhurtN9, spr_tv_exprhurtN10);
				}
			}
			else
			{
				with (obj_tv)
				{
					var str1 = sprite_get_name(sprite_index);
					var str2 = string_copy(str1, 0, string_length(str1) - 1);
					trace(str2);
					if ((state == states.expression || state == states.whitenoise) && (sprite_index == spr_tv_exprhurt || sprite_index == spr_tv_exprhurtN || sprite_index == spr_tv_hurtG || str2 == "spr_tv_exprhurt" || str2 == "spr_tv_exprhurtN"))
					{
						sprite_index = other.ispeppino ? spr_tv_idleN : spr_tv_idle;
						if (other.noisecrusher)
						{
							sprite_index = spr_tv_idleG;
						}
						var _palinfo = other.ispeppino ? get_noise_palette_info() : get_pep_palette_info();
						spr_palette = _palinfo.spr_palette;
						if (other.noisecrusher)
						{
							spr_palette = spr_ratmountpalette;
						}
						paletteselect = _palinfo.paletteselect;
						patterntexture = _palinfo.patterntexture;
					}
				}
				if (noisecrusher)
				{
					tv_do_expression(spr_tv_hurtG);
				}
				else
				{
					tv_do_expression(!ispeppino ? spr_tv_exprhurt : spr_tv_exprhurtN, true);
				}
				if (!ispeppino)
				{
					hurtTV = choose(spr_tv_exprhurt1, spr_tv_exprhurt2, spr_tv_exprhurt3, spr_tv_exprhurt4, spr_tv_exprhurt5, spr_tv_exprhurt6, spr_tv_exprhurt7, spr_tv_exprhurt8, spr_tv_exprhurt9, spr_tv_exprhurt10);
				}
				else
				{
					hurtTV = choose(spr_tv_exprhurtN1, spr_tv_exprhurtN2, spr_tv_exprhurtN3, spr_tv_exprhurtN4, spr_tv_exprhurtN5, spr_tv_exprhurtN6, spr_tv_exprhurtN7, spr_tv_exprhurtN8, spr_tv_exprhurtN9, spr_tv_exprhurtN10);
				}
			}
			if ((damage_n % 10) == 0)
			{
				tv_do_expression(hurtTV);
			}
			if (obj_tv.expressionsprite != spr_tv_exprhurt && obj_tv.expressionsprite != spr_tv_hurtG && obj_tv.expressionsprite != spr_tv_exprhurtN)
			{
				instance_destroy(obj_transfotip);
				var txt = lang_get_value("peppinohurt");
				if (!_swap)
				{
					if (isgustavo)
					{
						txt = lang_get_value("gustavohurt");
					}
					if (!ispeppino)
					{
						txt = lang_get_value("noisehurt");
					}
				}
				else if (noisecrusher)
				{
					txt = lang_get_value("gustavohurt");
				}
				else if (ispeppino)
				{
					txt = lang_get_value("noisehurt");
				}
				txt = embed_value_string(txt, [damage_n]);
				create_transformation_tip(txt);
			}
			var loseamount = 50;
			if (instance_exists(obj_bosscontroller))
			{
				loseamount = 0;
			}
			if (!global.pizzadelivery)
			{
				if (!instance_exists(obj_bosscontroller) && global.collect > 0)
				{
					with (instance_create(121, 60, obj_negativenumber))
					{
						number = concat("-", loseamount);
					}
				}
				global.collect -= loseamount;
				if (global.collect <= 0)
				{
					global.collect = 0;
				}
				if (global.collect != 0)
				{
					repeat (10)
					{
						with (instance_create(x, y, obj_pizzaloss))
						{
							sprite_index = choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect);
						}
					}

				}
			}
			with (obj_bosscontroller)
			{
				if (!instance_exists(obj_hpeffect))
				{
					if (!global.boss_invincible)
					{
						var n = 1;
						if (room == boss_fakepephallway)
						{
							n = 2;
						}
						repeat (n)
						{
							var pos = scr_bosscontroller_get_health_pos(player_hp, player_rowmax, player_columnmax, player_maxhp, player_hp_x, player_hp_y, player_xpad, player_ypad);
							if (pos != undefined)
							{
								var spr_pal = other.spr_palette;
								var pal = other.paletteselect;
								var tex = global.palettetexture;
								var hp_sprite = player_hpsprite;
								if (_swap)
								{
									var info = other.ispeppino ? get_noise_palette_info() : get_pep_palette_info();
									spr_pal = info.spr_palette;
									pal = info.paletteselect;
									tex = info.patterntexture;
									hp_sprite = other.ispeppino ? spr_bossfight_noiseHP : spr_bossfight_playerhp;
								}
								scr_bosscontroller_particle_hp(hp_sprite, irandom(sprite_get_number(hp_sprite) - 1), pos[0], pos[1], 1, spr_pal, pal, tex);
							}
							global.bossplayerhurt = true;
							player_hp--;
						}
					}
				}
				else
				{
					var d = instance_find(obj_hpeffect, instance_number(obj_hpeffect) - 1);
					scr_bosscontroller_particle_hp(spr_bossfight_playerhp, irandom(sprite_get_number(spr_bossfight_playerhp) - 1), d.x, d.y, (d.x > (room_width / 2)) ? -1 : 1, d.spr_palette, d.paletteselect, d.patterntexture);
					instance_destroy(d);
				}
			}
			if (_swap)
			{
				instance_create(0, 0, obj_swapmodeeffect);
			}
		}
	}
}
