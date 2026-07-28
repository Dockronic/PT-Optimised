var shakex = 0;
if (touched)
{
	shakex = random_range(-3, 3);
}
draw_sprite(sprite_index, image_index, x + shakex, y);
