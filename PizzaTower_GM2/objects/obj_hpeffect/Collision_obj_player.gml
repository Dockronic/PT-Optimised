if (finish)
{
	fmod_event_one_shot("event:/sfx/misc/cardcollect");
	global.hats++;
	instance_destroy();
}
