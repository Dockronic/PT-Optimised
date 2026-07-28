image_index = obj_player.image_index;
image_xscale = obj_player.xscale;
x = obj_player.x;
y = obj_player.y;
visible = obj_player.visible;
if (obj_player.sprite_index == obj_player.spr_playercorpsesurf)
{
	sprite_index = spr_corpsesurf;
}
if (obj_player.sprite_index == obj_player.spr_playercorpsestart)
{
	sprite_index = spr_corpsestart;
}
if (obj_player.state != states.trashroll && obj_player.state != states.chainsaw)
{
	instance_destroy();
}
