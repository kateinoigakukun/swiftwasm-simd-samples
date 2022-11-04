# Sample

```
$ swift build --triple wasm32-unknown-wasi -Xcc -msimd128 -c release
$ wasmtime run --enable-simd .build/release/Sample.wasm
```
