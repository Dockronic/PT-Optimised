function scr_string_width(_str)
{
	var pos = 0;
	var w = 0;
	var originalstr = _str;
	var str_arr = array_create(0);
	while (pos < string_length(originalstr))
	{
		if (string_copy(originalstr, pos, 2) == "\n")
		{
			array_push(str_arr, string_copy(originalstr, 1, pos));
			string_delete(originalstr, 1, pos);
			pos = 0;
			if (originalstr == "")
			{
				break;
			}
		}
		else
		{
			pos++;
		}
	}
	if (array_length(str_arr) == 0)
	{
		w = string_width(_str);
	}
	for (var i = 0; i < array_length(str_arr); i++)
	{
		var b = str_arr[i];
		if (string_width(b) > w)
		{
			w = string_width(b);
		}
	}
	return w;
}

function scr_separate_text(_str, _font, _targetwidth)
{
	if (_font != noone)
	{
		draw_set_font(_font);
	}
	var separation = lang_get_value("separation_map");
	separation = string_split(separation, ",");
	var _start_pos = 0;
	while (scr_string_width(_str) > (_targetwidth - string_width("a")))
	{
		var _pos = _start_pos;
		var _sep_pos = _pos;
		var len = string_length(_str);
		var found = false;
		while (_pos < len)
		{
			if (scr_is_separation(string_char_at(_str, _pos), separation))
			{
				var _prev_sep_pos = _sep_pos;
				_sep_pos = _pos;
				if (scr_string_width(string_copy(_str, _start_pos, _pos - _start_pos)) > (_targetwidth - string_width("a")))
				{
					_sep_pos = _prev_sep_pos;
					_start_pos = _sep_pos;
					_pos = _start_pos;
					found = true;
					break;
				}
			}
			_pos++;
		}
		if (string_char_at(_str, _sep_pos) == " ")
		{
			_str = string_delete(_str, _sep_pos, 1);
			_str = string_insert("\n", _str, _sep_pos);
		}
		else
		{
			_str = string_insert("\n", _str, _sep_pos + 1);
		}
	}
	return _str;
}

function scr_is_separation(_seperator, _seperation)
{
	for (var i = 0; i < array_length(_seperation); i++)
	{
		if (_seperator == _seperation[i])
		{
			return true;
		}
	}
	return false;
}

