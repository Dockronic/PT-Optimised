if (other.state != states.handstandjump && !hasgrabbed)
{
	if (other.state != states.knightpep && other.state != states.knightpepbump)
	{
		scr_hurtplayer(other);
	}
}
else if (!move)
{
	if (!grabbed && (other.state == states.handstandjump || other.state == states.punch || other.state == states.lungeattack) && !unpickable)
	{
		with (other)
		{
			image_index = 0;
			sprite_index = spr_haulingstart;
			baddiegrabbedID = other.id;
			grabbingenemy = true;
			state = states.grab;
		}
		playerid = other.object_index;
		grabbed = true;
	}
}
