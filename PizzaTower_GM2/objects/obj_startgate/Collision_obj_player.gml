var gate = id;
with (other)
{
	if (place_meeting(x, y, other) && key_up && grounded && (state == states.normal || state == states.mach1 || state == states.mach2 || state == states.mach3) && !instance_exists(obj_fadeout) && state != states.victory && state != states.comingoutdoor)
	{
		audio_stop_all();
		stop_music();
		global.collect = 0;
		global.leveltosave = other.level;
		global.leveltorestart = other.targetRoom;
		global.levelattempts = 0;
		backtohubstartx = x;
		backtohubstarty = y;
		backtohubroom = room;
		mach2 = 0;
		obj_camera.chargecamera = 0;
		image_index = 0;
		state = states.victory;
		exit;
	}
}
if (floor(obj_player.image_index) == (obj_player.image_number - 1) && obj_player.state == states.victory)
{
	with (obj_player)
	{
		targetDoor = other.targetDoor;
		targetRoom = other.targetRoom;
		if (targetRoom == tower_finalhallway)
		{
			global.exitrank = true;
		}
		if (gate.level != "tutorial")
		{
			if (gate.object_index != obj_bossdoor)
			{
				if (!instance_exists(obj_titlecard))
				{
					with (instance_create(x, y, obj_titlecard))
					{
						group_arr = gate.group_arr;
						titlecard_sprite = gate.titlecard_sprite;
						titlecard_index = gate.titlecard_index;
						title_sprite = gate.title_sprite;
						title_index = gate.title_index;
						title_music = gate.title_music;
					}
				}
			}
			else
			{
				with (instance_create_unique(0, 0, obj_fadeout))
				{
					restarttimer = true;
					group_arr = gate.group_arr;
				}
			}
		}
		else
		{
			with (instance_create_unique(0, 0, obj_fadeout))
			{
				restarttimer = true;
			}
		}
	}
}
