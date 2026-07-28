x = obj_player.x;
y = obj_player.y;
image_xscale = obj_player.xscale;
if (abs(obj_player.hsp) <= 0 || obj_player.state != states.mach3 || obj_player.state == states.slipbanan || abs(obj_player.movespeed) <= 12 || (obj_player.collision_flags & collisionflags.secret) > 0 || obj_player.cutscene || obj_player.state == states.comingoutdoor || obj_player.state == states.door || room == timesuproom)
{
	instance_destroy();
}
if (room == timesuproom)
{
	instance_destroy();
}
