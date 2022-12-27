import _CSample
import Foundation

struct Point {
    var x: Double
    var y: Double

    static func * (me: Point, other: Point) -> Point {
        Point(x: me.x * other.x, y: me.y * other.y)
    }
}

@inline(never)
@_optimize(none)
func makeVecs() -> (v128_t, v128_t) {
    return (wasm_f64x2_make(1.0, 2.0), wasm_f64x2_make(1.0, 1.0))
}

@inline(never)
@_optimize(none)
func makePoints() -> (Point, Point) {
    return (Point(x: 1.0, y: 2.0), Point(x: 1.0, y: 1.0))
}

let N: UInt64 = 1_000_000_000

@inline(never)
func doSIMD_C(_ vec1: v128_t, _ vec2: v128_t) -> v128_t {
    return _CSample.doSIMD_C(vec1, vec2)
}

@inline(never)
func doSIMD(_ vec1: v128_t, _ vec2: v128_t) -> v128_t {
    var vec1 = vec1
    for _ in 0..<N {
        vec1 = wasm_f64x2_mul(vec1, vec2)
    }
    return vec1
}

@inline(never)
func doBaseline() -> Point {
    var (point, point2) = makePoints()
    for _ in 0..<N {
        point = point * point2
    }
    return point
}

@main
public struct Sample {
    public static func main() {
        let (v1, v2) = makeVecs()
        print("SIMD (C):     \(ContinuousClock().measure { _ = doSIMD_C(v1, v2) })")
        print("SIMD (Swift): \(ContinuousClock().measure { _ = doSIMD(v1, v2) })")
        print("Baseline:     \(ContinuousClock().measure { _ = doBaseline() })")
    }
}
