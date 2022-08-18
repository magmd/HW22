import Foundation

public class WorkThread: Thread {

    private var storage: Stack<Chip>

    public init(storage: Stack<Chip>) {
        self.storage = storage
    }

    override public func main() {
        while storage.isAvailable || storage.isEmpty {
            let chip = storage.remove()
            chip.soldering()

            if storage.isFinished && storage.isEmpty {
                break
            }
        }
        print("Работа завершена")
    }
}

public class GeneratorThread: Thread {

    private var storage: Stack<Chip>
    private var timer = Timer()
    private var count = 0

    public init(storage: Stack<Chip>) {
        self.storage = storage
    }

    override public func main() {
        timer = Timer(timeInterval: 2, repeats: true) { [self] _ in
            storage.add(element: Chip.make())

            count += 2
            if count >= 20 {
                timer.invalidate()
                storage.isFinished = true
            }
        }

        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()
    }
}
