import Cocoa
import FinderSync
import NewFileNameGenerator

class FinderSync: FIFinderSync {
    
    // MARK: - Stored Properties
    
    let newFileBaseName = "new file"
    let newFileExtension = "txt"

    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        // Set up the directory we are syncing.
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/")]
    }
    
    // MARK: - Menu Items
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let menu = NSMenu(title: "")

        menu.addItem(
            withTitle: "New txt File",
            action: #selector(newTxtFile(_:)),
            keyEquivalent: ""
        )
        
        return menu
    }
    
    // MARK: - Actions
    
    @objc
    private func newTxtFile(_ sender: AnyObject?) {
        guard let folderURL = FIFinderSyncController.default().targetedURL() else { return }
        
        let fileManager = FileManager.default
        
        do {
            let contentsOfDirectory = try fileManager.contentsOfDirectory(
                at: folderURL,
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles
            )
            
            let newFileNameGenerator = NewFileNameGenerator(
                fileBaseName: newFileBaseName,
                fileExtension: newFileExtension
            )
            let newFileName = newFileNameGenerator.makeNewFileName(for: contentsOfDirectory)
            
            let newFileURL = folderURL
                .appendingPathComponent(newFileName)
                .appendingPathExtension(newFileExtension)
            
            // Write blank file to disk.
            try "".write(to: newFileURL, atomically: true, encoding: .utf8)
            
        } catch {
            print(error)
            return
        }
    }
}
