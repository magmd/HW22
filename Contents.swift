import Foundation

let storage = Stack<Chip>()

let workThread = WorkThread(storage: storage)
let generatorThread = GeneratorThread(storage: storage)

workThread.start()
generatorThread.start()

