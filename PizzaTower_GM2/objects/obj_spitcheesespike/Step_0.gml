if (vsp < 12)
{
	vsp += grav;
}
image_speed = 0;
if (place_meeting(x + floor(hsp), y, noone))
{
	x = floor(x);
	while (!place_meeting(x + sign(hsp), y, noone))
	{
		x += sign(hsp);
	}
	hsp = 0;
}
x += hsp;
if (place_meeting(x, y + floor(vsp), noone))
{
	y = floor(y);
	while (!place_meeting(x, y + sign(vsp), noone))
	{
		y += sign(vsp);
	}
	vsp = 0;
}
y += floor(vsp);
