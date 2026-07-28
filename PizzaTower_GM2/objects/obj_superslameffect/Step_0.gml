x = obj_player.x;
y = obj_player.y;
if (obj_player.state != states.freefall && obj_player.state != states.superslam && obj_player.sprite_index != spr_player_ratmountwalljump)
{
	instance_destroy();
}
visible = !(room == rank_room);
