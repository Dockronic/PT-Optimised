if (current_arr > (array_length(content_arr) - 1))
{
	exit;
}
scr_sound_multiple("event:/sfx/misc/collect", x, y);
global.combotime += 10;
global.combotime = clamp(global.combotime, 0, 60);
global.collect += 10;
create_collect(x, y, choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect), 10);
with (instance_create(x + 16, y, obj_smallnumber))
{
	number = string(10);
}
current_arr++;
alarm[0] = count;
