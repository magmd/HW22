import Foundation

public class Stack<T> {
    public var isAvailable = false
    public var isFinished = false

    private var array = [T]()
    private let condition = NSCondition()

    public init() {}

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public func add(element: T) {
        condition.lock()
        array.append(element)
        print("Чип добавлен")
        print("Чипов в наличии: \(array.count)")
        isAvailable = true
        condition.signal()
        condition.unlock()
    }

    public func remove() -> T {
        condition.lock()
        while !isAvailable {
            condition.wait()
        }
        let element = array.removeLast()
        if isEmpty {
            isAvailable = false
        }
        print("Чип удален")
        print("Чипов в наличии после удаления: \(array.count)")
        print()
        condition.unlock()

        return element
    }
}
