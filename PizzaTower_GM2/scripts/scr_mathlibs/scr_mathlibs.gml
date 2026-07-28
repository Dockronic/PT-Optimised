function magnitude(_x, _y)
{
	return sqrt(abs(_x) + abs(_y));
}

function cycle(_value, _min, _max)
{
	var delta = _max - _min;
	var result = (_value - _min) % delta;
	if (result < 0)
	{
		result += delta;
	}
	return result + _min;
}

function angle_rotate(_current_angle, _target_angle, _speed)
{
	var diff = cycle(_target_angle - _current_angle, -180, 180);
	if (diff < -_speed)
	{
		return _current_angle - _speed;
	}
	if (diff > _speed)
	{
		return _current_angle + _speed;
	}
	return _target_angle;
}

function Wave(_from, _to, _length, _offset, _time = noone)
{
	var a4 = (_to - _from) * 0.5;
	var t = current_time;
	if (_time != noone)
	{
		t = _time;
	}
	return _from + a4 + (sin((((t * 0.001) + (_length * _offset)) / _length) * (2 * pi)) * a4);
}

function distance_to_pos(_x1, _y1, _x2, _y2, _max_x, _max_y)
{
	return abs(_x1 - _x2) <= _max_x && abs(_y1 - _y2) <= _max_y;
}

function distance_between_points(_x1, _y1, _x2, _y2)
{
	return sqrt(sqr(_x2 - _x1) + sqr(_y2 - _y1));
}

function calculate_jump_velocity(_target_x, _target_y, _spd, _grav)
{
	var a = get_projectile_angle(x, y, _target_x, _target_y, _spd, _grav);
	hsp = lengthdir_x(_spd, a);
	vsp = lengthdir_y(_spd, a);
}

function get_projectile_angle(_x, _y, _target_x, _target_y, _spd, _grav)
{
	var xt = floor(_target_x - _x);
	var yt = -floor(_target_y - _y);
	var root = power(_spd, 4) - (_grav * ((_grav * sqr(xt)) + (2 * sqr(_spd) * yt)));
	var angle = 0;
	if (root > 0)
	{
		angle = radtodeg(arctan((sqr(_spd) + sqrt(root)) / (_grav * xt)));
		if (xt < 0)
		{
			angle -= 180;
		}
	}
	else if (xt > 0)
	{
		angle = 45;
	}
	else
	{
		angle = 135;
	}
	return angle;
}
