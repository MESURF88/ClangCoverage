#include <iostream>
#include "tmp.h"

static int test_me(int x);

void pubfunc(int x)
{
	if(x < 0)
	{
		std::cout << "neg" << std::endl;
	}
	else
	{
		std::cout << "pos" << std::endl;		
	}
}

static int test_me(int x)
{
	int tmp = x + 1;
	return tmp;
}