#include <wasm_simd128.h>

inline v128_t doSIMD_C(v128_t vec1, v128_t vec2) {
  for (int i = 0; i < 1000000000; i++) {
    vec1 = wasm_f64x2_mul(vec1, vec2);
  }
  return vec1;
}
