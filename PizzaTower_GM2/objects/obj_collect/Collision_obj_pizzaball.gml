
if (object_index != obj_escapecollect)
{
	scr_sound_multiple("event:/sfx/misc/collect", x, y);
}
else
{
	scr_sound_multiple("event:/sfx/misc/bellcollect", x, y);
}
global.combotime += 10;
global.combotime = clamp(global.combotime, 0, 60);
global.collect += 10;
create_collect(x, y, sprite_index, 10);
with (instance_create(x + 16, y, obj_smallnumber))
{
	number = string(10);
}
instance_destroy();
