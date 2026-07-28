with (other)
{
	if (scr_transformationcheck())
	{
		if (state != states.firemouth && state != states.parry && !hurted)
		{
			fmod_event_one_shot_3d("event:/sfx/firemouth/start", x, y);
			create_transformation_tip(lang_get_value("firemouthtip"), "firemouth");
			firemouthflames = false;
			hsp = 0;
			movespeed = 0;
			state = states.firemouth;
			image_index = 0;
			sprite_index = spr_firemouthintro;
			state = states.firemouth;
			bombpeptimer = 3;
			instance_destroy(other);
		}
	}
}
