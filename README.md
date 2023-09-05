# wasix-sysroot
A minimal sysroot for building C/C++ against wasix-libc.

# Background

[wasix-libc](https://github.com/wasix-org/wasix-libc) provides a variant of [wasi-libc](https://github.com/WebAssembly/wasi-libc) with useful extensions which are supported in the [Wasmer](https://github.com/wasmerio/wasmer) WASM runtime.

However, where `wasi-libc` has a readily available SDK ([wasi-sdk](https://github.com/WebAssembly/wasi-sdk), which also includes a full `sysroot` in its release assets, `wasix-libc` does not. That makes it cumbersome to build against `wasix-libc`, especially when using C++, as one first needs to build `libc++` against `wasix-libc`.

This repo provides scripts to build a sysroot that allows C/C++ development against the full `wasix-libc` including derived `libc++`. It can be used to build directly using `clang` (no `wasienv` / `wasicc` needed).

# Installation

Grab one of the releases from this repo.

To build from source is a bit more complicated. Right now, the steps are embedded in a Github Actions script. Please check and replicate the steps from .github/workflows/build.yml.

# Usage

For building CMake projects, a toolchain file is included in the sysroot at `wasix-sysroot/clang-wasm.cmake_toolchain`.
In addition to specifying the toolchain, you also need to make sure of a few things:

### Ensure the wasm-ld is available

`wasm-ld` is needed for linking. It is usually available in your system's linking package. It should be in the `PATH`.

### Build with the correct CMAKE settings

`CMAKE_TOOLCHAIN_FILE` and `CMAKE_SYSROOT` should both be set by you. Example:

```
cmake -DCMAKE_TOOLCHAIN_FILE=/path/to/wasix-sysroot/clang-wasm.cmake_toolchain -DCMAKE_SYSROOT=/path/to/wasix-sysroot /path/to/my/project
```