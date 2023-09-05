# wasix-sysroot
A sysroot for building C/C++ against wasix-libc.

# Background

[wasix-libc](https://github.com/wasix-org/wasix-libc) provides a variant of [wasi-libc](https://github.com/WebAssembly/wasi-libc) with useful extensions which are supported in the [Wasmer](https://github.com/wasmerio/wasmer) WASM runtime.

However, where `wasi-libc` has a readily available SDK ([wasi-sdk](https://github.com/WebAssembly/wasi-sdk), which also includes a full `sysroot` in its release assets, `wasix-libc` does not. That makes it cumbersome to build against `wasix-libc`, especially when using C++, as one first needs to build `libc++` against `wasix-libc`.

This repo provides scripts to build a full `wasix-libc` sysroot including `libc++`. It can be used to build directly using `clang` (no `wasienv` / `wasicc` needed).
