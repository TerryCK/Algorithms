import Foundation

open class Benchmark {
    public static func measure(times: Int = 1, id: String, block: () -> Void) -> Double {
        let begin = Date()
        (0...times).forEach { _ in
            block()
        }
        let timeElapsed = Date().timeIntervalSince(begin) * 1000 / Double(times)
        print("measure id:", id, "times: \(times)", "average:", timeElapsed, "ms")
        
        return timeElapsed
    }
}
