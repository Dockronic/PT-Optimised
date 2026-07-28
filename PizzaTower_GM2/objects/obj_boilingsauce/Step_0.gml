
var playerid = instance_place(x, y - 1, obj_player);
with (playerid)
{
	if (state != states.boots && state != states.gameover && state != states.rideweenie && state != states.gotoplayer)
	{
		GamepadSetVibration(0, 1, 1, 0.85);
		if (state != states.fireass)
		{
			notification_push(notifications.touched_lava, [room]);
		}
		state = states.fireass;
		vsp = -20;
		fireasslock = false;
		sprite_index = spr_fireass;
		image_index = 0;
		movespeed = hsp;
		fmod_event_one_shot_3d("event:/sfx/pep/burn", x, y);
		if (!fmod_event_instance_is_playing(global.snd_fireass))
		{
			fmod_event_instance_play(global.snd_fireass);
		}
	}
}
