draw_sprite_ext(spr_ventilator, ventilator_index, x, (y + sprite_height) - 32, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (draw)
{
	for (var i = 0; i < array_length(leaves); i++)
	{
		with (leaves[i])
		{
			draw_sprite_ext(spr_ventilatorleaf, image_index, x, y, 1, 1, 0, c_white, image_alpha);
		}
	}
}
