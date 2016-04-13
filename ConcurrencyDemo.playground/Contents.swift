
import Foundation
import QuartzCore

//: Subclassing NSOperation

class TestOperation: NSOperation {
    var sum = 0

    override func start() {
        sum = 2 + 5
    }
}

let testOps = TestOperation()
testOps.start()
testOps.sum

//: Using NSBlockOperation

let operation = NSBlockOperation()

var sum = 0

operation.addExecutionBlock {
    sum = 1 + 2
}

operation.start()

sum

//: Using NSBlockOperation with multiple blocks


let multioperation = NSBlockOperation()

multioperation.addExecutionBlock {
    sum = sum + 1 + 2
}
multioperation.addExecutionBlock {
    sum = sum + 1 + 2
}
multioperation.addExecutionBlock {
    sum = sum + 1 + 2
}
multioperation.addExecutionBlock {
    sum = sum + 1 + 2
}
multioperation.addExecutionBlock {
    sum = sum + 1 + 2
}

multioperation.start()

sum

//: NSOperationQueue, note the maxConcurrentOperation
//: the time taken to complte all the operations

let operationQueue = NSOperationQueue()

operationQueue.maxConcurrentOperationCount
operationQueue.qualityOfService = NSQualityOfService.Utility
operationQueue.cancelAllOperations()
operationQueue.waitUntilAllOperationsAreFinished()

operationQueue.maxConcurrentOperationCount = 2
 
let startTime = CACurrentMediaTime()
 
operationQueue.addOperationWithBlock({print(1); sleep(1)})
operationQueue.addOperationWithBlock({print(2); sleep(1)})
operationQueue.addOperationWithBlock({print(3); sleep(1)})
operationQueue.addOperationWithBlock({print(4); sleep(1)})
operationQueue.addOperationWithBlock({print(5); sleep(1)})
operationQueue.waitUntilAllOperationsAreFinished()
 
let endTime = CACurrentMediaTime()
 
let time = endTime - startTime

//: NSOperationQueuem and NSOperaton with dependency

var result = 0

let op1 = NSBlockOperation {
    result = result + 10
    sleep(1)
    print(result)
}


let op2 = NSBlockOperation {
    result = result + 25
    sleep(1)
    print(result)
}



let op3 = NSBlockOperation {
    result = result + 35
    sleep(1)
    print(result)
}

op2.addDependency(op1)
op3.addDependency(op2)

let oq1 = NSOperationQueue()

oq1.maxConcurrentOperationCount

oq1.addOperation(op1)
oq1.addOperation(op2)
oq1.addOperation(op3)
oq1.waitUntilAllOperationsAreFinished()

result


