# wasix-sysroot
A minimal sysroot for building C/C++ against wasix-libc.

# NOTICE

Rather than continue this repo, maintainers of `wasix-libc` have suggested to merge the build scripts from here into `wasix-libc` and release a sysroot from there. For the time being, will keep this repository up as long as there are no releases from the `wasix-libc` side.


# Background

[wasix-libc](https://github.com/wasix-org/wasix-libc) provides a variant of [wasi-libc](https://github.com/WebAssembly/wasi-libc) with useful extensions which are supported in the [Wasmer](https://github.com/wasmerio/wasmer) WASM runtime.

However, where `wasi-libc` has a readily available SDK ([wasi-sdk](https://github.com/WebAssembly/wasi-sdk)), which also includes a full `sysroot` in its release assets, `wasix-libc` does not. That makes it cumbersome to build against `wasix-libc`, especially when using C++, as one first needs to build `libc++` against `wasix-libc`.

This repo provides scripts to build a sysroot that allows C/C++ development against the full `wasix-libc` including derived `libc++`. It can be used to build directly using `clang` (no `wasienv` / `wasicc` needed).

# Status

The sysroot builds, but has not been extensively tested. Some issues have been identified (see the issue tracker). There are some tests included which show the status of several WASIX features. The CI test of this repo shows as "failed" as long as some of these tests still fail.

# Installation

Grab one of the releases from this repo.

To build from source is a bit more complicated. Right now, the steps are embedded in a Github Actions script. Please check and replicate the steps from `.github/workflows/build.yml`. Obviously, since the whole sysroot is `wasm`, it's cross-platform so the pre-built sysroot should suffice whatever your platform is.

# Usage

For building CMake projects, a toolchain file is included in the sysroot at `wasix-sysroot/clang-wasm.cmake_toolchain`.
In addition to specifying the toolchain, you also need to make sure of a few things:

### Ensure the wasm-ld is available

`wasm-ld` is needed for linking. It is usually available in your system's `LLVM` linker package. It should be in the `PATH`.

### Build with the correct CMAKE settings

`CMAKE_TOOLCHAIN_FILE` and `CMAKE_SYSROOT` should both be set by you. Example:

```
cmake -DCMAKE_TOOLCHAIN_FILE=/path/to/wasix-sysroot/clang-wasix.cmake_toolchain -DCMAKE_SYSROOT=/path/to/wasix-sysroot /path/to/my/project
```
