import _CSample

@main
public struct Sample {
    public static func main() {
        let a: SIMD4<Int8> = [1, 2, 3, 4]
        let b: SIMD4<Int8> = [1, 1, 1, 1]
        print(a & b)
    }
}
