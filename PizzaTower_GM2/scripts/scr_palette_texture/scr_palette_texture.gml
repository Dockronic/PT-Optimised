function scr_get_texture_array()
{
	return
	[
		["funny", spr_peppattern1],
		["itchy", spr_peppattern2],
		["pizza", spr_peppattern3],
		["stripes", spr_peppattern4],
		["goldemanne", spr_peppattern5],
		["bones", spr_peppattern6],
		["pp", spr_peppattern7],
		["war", spr_peppattern8],
		["john", spr_peppattern9],
		["candy", spr_peppattern10],
		["bloodstained", spr_peppattern11],
		["bat", spr_peppattern12],
		["pumpkin", spr_peppattern13],
		["fur", spr_peppattern14],
		["flesh", spr_peppattern15],
		["racer", spr_noisepattern1],
		["comedian", spr_noisepattern2],
		["banana", spr_noisepattern3],
		["noiseTV", spr_noisepattern4],
		["madman", spr_noisepattern5],
		["bubbly", spr_noisepattern6],
		["welldone", spr_noisepattern7],
		["grannykisses", spr_noisepattern8],
		["towerguy", spr_noisepattern9]
	];
}

function scr_get_texture_palette(_pattern_name)
{
	var _arr = scr_get_texture_array();
	if (_pattern_name != "none")
	{
		for (var i = 0; i < array_length(_arr); i++)
		{
			if (_arr[i][0] == _pattern_name)
			{
				return _arr[i][1];
			}
		}
	}
	return noone;
}

function scr_get_texture_name(_patternspr)
{
	var _arr = scr_get_texture_array();
	if (_patternspr != noone)
	{
		for (var i = 0; i < array_length(_arr); i++)
		{
			if (_arr[i][1] == _patternspr)
			{
				return _arr[i][0];
			}
		}
	}
	return "none";
}

