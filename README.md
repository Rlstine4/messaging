# messaging

## Overview

TODO:

## Requirements

- CMake 3.26 or newer
- A C++20-capable compiler

## Build

Configure and build the Debug version:

```sh
cmake --preset debug
cmake --build --preset debug
```

Use `release` instead of `debug` for a Release build.

To install it to a local prefix:

```sh
cmake --install build/debug --prefix "$HOME/.local"
```

This library can be used as a submodule:

```cmake
add_subdirectory(submodules/messaging)
target_link_libraries(my_app PRIVATE messaging::messaging)
```

Or use the installed package:

```cmake
find_package(messaging CONFIG REQUIRED)
target_link_libraries(my_app PRIVATE messaging::messaging)
```

## Tests

TODO
