function scr_initinput2()
{
	ini_open("saveData.ini");
	global.key_jumpN = ini_read_string("ControlsKeys2", "jump", ord("L"));
	ini_close();
}
