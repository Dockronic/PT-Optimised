image_speed = 0.35;
with (obj_player)
{
	if (!place_meeting(x, y, obj_uparrowhitbox))
	{
		instance_destroy(other);
	}
	if (!grounded || (state != states.normal && state != states.ratmount))
	{
		instance_destroy(other);
	}
}
x = obj_player.x;
y = obj_player.y - 50;
