with (other)
{
	if (state != states.boots && state != states.gameover && state != states.rideweenie && state != states.gotoplayer && state != states.backbreaker)
	{
		GamepadSetVibration(0, 1, 1, 0.85);
		hurted = false;
		state = states.fireass;
		vsp = -25;
		fireasslock = true;
		sprite_index = spr_fireass;
		image_index = 0;
		hsp = 0;
		movespeed = 0;
		fmod_event_one_shot_3d("event:/sfx/pep/burn", x, y);
		if (!fmod_event_instance_is_playing(global.snd_fireass))
		{
			fmod_event_instance_play(global.snd_fireass);
		}
		instance_destroy(other);
	}
}
