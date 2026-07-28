x = obj_player.x;
y = obj_player.y;
mask_index = obj_player.mask_index;
xs = Approach(xs, 1, 0.12);
image_xscale = xs;
image_yscale = xs;
if (place_meeting(x, y, obj_secretportal) || (place_meeting(x, y, obj_secretportalstart) && !instance_place(x, y, obj_secretportalstart).drop))
{
	visible = false;
}
else
{
	visible = obj_player.visible;
}
if (sprite_index == spr_antigrav_bubblesquish && ANIMATION_END)
{
	sprite_index = spr_antigrav_bubble;
}
if (obj_player.state != states.antigrav && obj_player.state != states.chainsaw && (obj_player.state != states.teleporter || (obj_player.tauntstoredstate != states.antigrav && !visible)))
{
	instance_destroy();
}
