image_speed = 0.35;
image_xscale = obj_player.xscale;
x = obj_player.x;
y = obj_player.y;
if (global.combo < 25 || obj_player.state != states.normal)
{
	instance_destroy();
}
if (obj_player.sprite_index == obj_player.spr_catched)
{
	visible = false;
}
