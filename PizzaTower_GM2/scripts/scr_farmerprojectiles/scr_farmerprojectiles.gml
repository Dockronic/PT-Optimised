function scr_change_farmers()
{
	var i = 0;
	while (i < 3)
	{
		farmerpos++;
		if (farmerpos > (array_length(global.hasfarmer) - 1))
		{
			farmerpos = 0;
		}
		if (global.hasfarmer[farmerpos])
		{
			break;
		}
	}
	farmer_rearrange();
}
