import Foundation

func physicalCoreCount() -> Int? {
    #if os(macOS)
        var count: Int32 = 0
        var size = MemoryLayout<Int32>.size
        guard sysctlbyname("hw.physicalcpu", &count, &size, nil, 0) == 0 else {
            return nil
        }
        return Int(count)
    #elseif os(Linux)
        // Each physical core lists the logical CPUs (hyperthreads) it hosts;
        // count the distinct lists.
        let cpuDir = "/sys/devices/system/cpu"
        guard let entries = try? FileManager.default.contentsOfDirectory(atPath: cpuDir) else {
            return nil
        }

        var cores = Set<String>()
        for entry in entries where entry.hasPrefix("cpu") && Int(entry.dropFirst(3)) != nil {
            let topology = "\(cpuDir)/\(entry)/topology"
            let siblings = (try? String(contentsOfFile: "\(topology)/core_cpus_list", encoding: .utf8))
                ?? (try? String(contentsOfFile: "\(topology)/thread_siblings_list", encoding: .utf8))
            if let siblings {
                cores.insert(siblings.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
        return cores.isEmpty ? nil : cores.count
    #else
        return nil
    #endif
}

let logicalCores = ProcessInfo.processInfo.processorCount

if let physicalCores = physicalCoreCount() {
    print("Physical cores: \(physicalCores)")
} else {
    print("Physical cores: unknown")
}
print("Logical cores: \(logicalCores)")
