image_xscale = obj_player.xscale;
x = obj_player.x;
y = obj_player.y;
if (obj_player.sprite_index != spr_knightpep_attack && obj_player.state != states.parry && obj_player.state != states.finishingblow)
{
	instance_destroy();
}
