import Foundation

let physicalCores = ProcessInfo.processInfo.activeProcessorCount
let logicalCores = ProcessInfo.processInfo.processorCount

print("Physical cores: \(physicalCores)")
print("Logical cores: \(logicalCores)")
