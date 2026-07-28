function scr_deactivate_escape()
{
	with (obj_baddie)
	{
		hitboxcreate = false;
		boundbox = false;
		event_perform(ev_other, ev_room_start);
	}
}
