#macro IS_WINDOWS 1
#macro IS_DEBUG (GM_build_type == "run")


enum debug_texttypes
{
	plain = 0,
	command = 1,
	debug_log = 2,
	error = 3,
}
