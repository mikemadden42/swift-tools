# swift-tools

Small command-line tools written in Swift. They build on macOS and Linux.

## Tools

- `cores` prints the number of physical and logical CPU cores.
- `list` lists the files in the current directory, grouped by extension.
- `password <length>` generates a random password of the given length.

## Building

```sh
make        # build all tools
make cores  # build one tool
make clean  # remove built tools
```

On macOS, each tool is built as a stripped universal binary (x86_64 + arm64).
On Linux, each tool is built as a stripped native binary.

### CMake

The tools can also be built with CMake (3.15 or later), which requires the
Ninja or Xcode generator:

```sh
cmake -B build -GNinja
ninja -C build
```

The build type defaults to `Release`, which strips the binaries; pass
`-DCMAKE_BUILD_TYPE=Debug` for an unstripped debug build. CMake cannot build
universal Swift binaries, so on macOS it builds for the host architecture
only, targeting the same minimum macOS versions as `make` (11.0 for arm64,
10.15 for x86_64).

## macOS toolchain

Show the active developer directory:

```sh
xcode-select -p
```

Switch to the Command Line Tools:

```sh
sudo xcode-select --switch /Library/Developer/CommandLineTools
```

Switch to Xcode:

```sh
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

## Formatting and linting

```sh
swiftformat --swiftversion 6 --strict *.swift
swiftlint --strict *.swift
```
