if (lock)
{
	exit;
}
if (followid != noone && !instance_exists(obj_player))
{
	exit;
}
playerid = obj_player.id;
if (obj_player.state != states.ladder && obj_player.state != states.door && obj_player.state != states.comingoutdoor)
{
	if (space < maxspace && dir == -1)
	{
		space += spaceaccel;
	}
	if (space > -maxspace && dir == 1)
	{
		space -= spaceaccel;
	}
}
else
{
	space = Approach(space, 0, spaceaccel);
}
if (dir != obj_player.xscale)
{
	dir = obj_player.xscale;
}
if (followid == noone && object_index != obj_swapmodefollow && instance_exists(obj_swapmodefollow))
{
	followid = obj_swapmodefollow.id;
}
if (followid != noone && !instance_exists(followid))
{
	followid = noone;
}
var tx = round(xoffset * space);
var xx = (followid == noone) ? obj_player.x : followid.x;
var yy = (followid == noone) ? obj_player.y : followid.y;
var msk = (followid == noone) ? obj_player.mask_index : followid.mask_index;
var ixs = (followid == noone) ? obj_player.xscale : followid.image_xscale;
ds_queue_enqueue(followqueue, xx + tx);
ds_queue_enqueue(followqueue, yy);
ds_queue_enqueue(followqueue, msk);
ds_queue_enqueue(followqueue, ixs);
if (ds_queue_size(followqueue) > (LAG_STEPS * 2))
{
	var _x = ds_queue_dequeue(followqueue);
	var _y = ds_queue_dequeue(followqueue);
	if (!use_collision)
	{
		if (interp < 1)
		{
			x = lerp(x, _x, interp);
			y = lerp(y, _y, interp);
			interp = Approach(interp, 1, 0.01);
		}
		else
		{
			x = _x;
			y = _y;
		}
	}
	mask_index = ds_queue_dequeue(followqueue);
	image_xscale = ds_queue_dequeue(followqueue);
}
image_xscale = obj_player.xscale * obj_player.scale_xs;
image_yscale = obj_player.yscale * obj_player.scale_ys;
following_moonwalk_fix();
