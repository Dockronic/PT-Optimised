if (instance_exists(obj_player))
{
	if (room != obj_player.targetRoom || roomreset)
	{
		var r = room;
		room_goto(obj_player.targetRoom);
		if (r == tower_peppinohouse)
		{
			scr_unlock_swap();
		}
		with (obj_player)
		{
			if (state == states.ejected || state == states.taxi2)
			{
				visible = true;
				state = states.normal;
			}
		}
	}
}
