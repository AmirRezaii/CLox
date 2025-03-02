#define NOB_IMPLEMENTATION
#include "nob.h"

#define BUILD_DIR "build/"
#define SRC_DIR "src/"

int main(int argc, char **argv) {
  NOB_GO_REBUILD_URSELF(argc, argv);

  if (!nob_mkdir_if_not_exists(BUILD_DIR)) return 1;

  Nob_Cmd cmd = {0};

  nob_cmd_append(&cmd, "cc",
                 "-o", BUILD_DIR"clox",
                 "-Wall", "-Wextra", "-pedantic", "-ggdb",
                 SRC_DIR"main.c", SRC_DIR"table.c", SRC_DIR"chunk.c", SRC_DIR"value.c", SRC_DIR"memory.c", SRC_DIR"debug.c", SRC_DIR"vm.c", SRC_DIR"scanner.c", SRC_DIR"compiler.c", SRC_DIR"object.c");

  if (!nob_cmd_run_sync(cmd)) return 1;

  return 0;
}
