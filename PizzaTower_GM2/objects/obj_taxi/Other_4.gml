if (global.panic && escape == false)
{
	instance_destroy();
}
else if (!global.panic && escape)
{
	instance_destroy();
}
