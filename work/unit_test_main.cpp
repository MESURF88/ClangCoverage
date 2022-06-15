#include <iostream>

#include "gtest/gtest.h"
#include "tmp.h"

GTEST_TEST(sample_test_case, sample_test)
{
    EXPECT_EQ(true, 1);
}

GTEST_TEST(tmp, pubfunctest)
{
	pubfunc(5);
    EXPECT_EQ(1, 1);
}

/*
#include "tmp.cpp"
GTEST_TEST(tmp, test_me)
{
	int x = test_me(5);
    EXPECT_EQ(x, 6);
}
*/

