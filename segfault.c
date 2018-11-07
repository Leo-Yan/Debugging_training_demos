#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	int *ptr = 0xffff800033e6c698;

	*ptr = 0x1354;
	return 0;
}
