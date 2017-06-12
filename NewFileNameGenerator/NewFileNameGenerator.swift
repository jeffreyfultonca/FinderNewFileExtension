import Foundation

public struct NewFileNameGenerator {
    
    private let fileBaseName: String
    private let fileExtension: String
    
    public init(fileBaseName: String, fileExtension: String) {
        self.fileBaseName = fileBaseName
        self.fileExtension = fileExtension
    }
    
    public func makeNewFileName(for contentsOfDirectory: [URL]) -> String {
        let existingFileURLs = contentsOfDirectory.filter({
            $0.lastPathComponent.hasPrefix(fileBaseName) && $0.pathExtension == fileExtension
        })
        
        let existingFileNames = existingFileURLs.map({ $0.deletingPathExtension().lastPathComponent })
        
        var iteration = 0
        var newFileName = fileBaseName
        
        while existingFileNames.contains(newFileName) {
            iteration += 1
            newFileName = "\(fileBaseName) \(iteration)"
        }
        
        return newFileName
    }
}
