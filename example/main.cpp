#include "pch.h"
#include <string>
#include "example.h"
#include "log.h"

  int main()
{
	std::string msg = example::get_message();
	logging::info(msg);
}
