#include "List.h"
#include "Map.h"
#include "Log.h"
#include "xcb_test.h"

int main() {
  Log log;
  List list;
  Map map;
  log.log("abc");
  xcb_test();
  return 0;
}