import Foundation

let fileManager = FileManager.default
let currentPath = fileManager.currentDirectoryPath

do {
    let items = try fileManager.contentsOfDirectory(atPath: currentPath)
    var filesByExtension: [String: [String]] = [:]

    for item in items {
        // Skip dotfiles and directories
        if item.hasPrefix(".") {
            continue
        }

        let fullPath = (currentPath as NSString).appendingPathComponent(item)
        var isDirectory: ObjCBool = false

        if fileManager.fileExists(atPath: fullPath, isDirectory: &isDirectory), !isDirectory.boolValue {
            let fileExtension = (item as NSString).pathExtension.lowercased()
            filesByExtension[fileExtension, default: []].append(item)
        }
    }

    // Sort extensions and files within each extension
    for ext in filesByExtension.keys.sorted() {
        print("\n\(ext):")
        for file in filesByExtension[ext]!.sorted() {
            print("- \(file)")
        }
    }
} catch {
    print("Error reading directory: \(error)")
}
