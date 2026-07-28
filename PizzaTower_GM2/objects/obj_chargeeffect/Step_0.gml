image_xscale = obj_player.xscale;
if (obj_player.state != states.rocket && obj_player.gusdashpadbuffer <= 0 && obj_player.state != states.mach3 && obj_player.ratmount_movespeed < 12 && obj_player.state != states.crouchslide && obj_player.state != states.shoulderbash)
{
	instance_destroy();
}
x = obj_player.x + (((obj_player.sprite_index == spr_player_Sjumpcancel) ? 20 : 0) * obj_player.xscale);
y = obj_player.y;
if (obj_player.state == states.rocket)
{
	x = obj_player.x + (obj_player.xscale * 18);
}
if (obj_player.state == states.ratmount)
{
	x = obj_player.x + (obj_player.xscale * 18);
}
if (obj_player.sprite_index == obj_player.spr_fightball)
{
	x = obj_player.x + (obj_player.xscale * 18);
}
visible = !(room == rank_room);
if (place_meeting(x, y, obj_secretportal) || place_meeting(x, y, obj_secretportalstart))
{
	visible = false;
}
if (obj_player.sprite_index == obj_player.spr_rocketstart)
{
	visible = false;
}
