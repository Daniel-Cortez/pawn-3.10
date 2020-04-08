#include <core>
#include <console>

new global_var;
static global_static_var;

test_local()
{
	new local_var;
	local_var = 1;
	local_var = 2; // warning 240
	local_var = 3; // warning 240
	#pragma unused local_var
	local_var = 4; // warning 204
	new local_var2 = 0;
	local_var2 = 1;
	#pragma unused local_var2
}

test_local_static()
{
	static local_static_var = 0;
	local_static_var = 1; // warning 240
	local_static_var = 2; // warning 240
	#pragma unused local_static_var
	local_static_var = 4;
}

test_global()
{
	global_var = 1;
	global_var = 2;
	global_var = 3;
	#pragma unused global_var
	global_var = 4;
}

test_global_static()
{
	global_static_var = 1;
	global_static_var = 2;
	global_static_var = 3;
	#pragma unused global_static_var
	global_static_var = 4;
}

test_arg(arg)
{
	arg = 0; // warning 240
	arg = 1; // warning 240, warning 204
}

stock Tag:operator =(oper)
	return Tag:oper;

test_ovl_assignment()
{
	// Overloaded assignments are essentially function calls which may have
	// desirable side effects, so they shouldn't trigger warning 204.
	new Tag:a = 1;
	new Tag:b;
	b = 2;
}

main()
{
	test_local();
	test_local_static();
	test_global();
	test_global_static();
	new x = 0;
	test_arg(x);
	test_ovl_assignment();
}
