import XCTest
@testable import NewFileNameGenerator

class NewFileNameGeneratorTests: XCTestCase {
    
    private let fileBaseName = "new file"
    private let fileExtension = "txt"
    
    private var generator: NewFileNameGenerator!
    
    override func setUp() {
        super.setUp()
        
        generator = NewFileNameGenerator(
            fileBaseName: fileBaseName,
            fileExtension: fileExtension
        )
    }
    
    func testEmptyDirectory() {
        let directoryContents: [URL] = []
        
        let expected = "new file"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDirectoryWithBaseName() {
        let directoryContents: [URL] = [
            URL(fileURLWithPath: "/files/new file.txt")
        ]
        
        let expected = "new file 1"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDirectoryWithBaseNameAndBaseName1() {
        let directoryContents: [URL] = [
            URL(fileURLWithPath: "/files/new file.txt"),
            URL(fileURLWithPath: "/files/new file 1.txt")
        ]
        
        let expected = "new file 2"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDirectoryWithBaseNameAndBaseName1AndBaseName2() {
        let directoryContents: [URL] = [
            URL(fileURLWithPath: "/files/new file.txt"),
            URL(fileURLWithPath: "/files/new file 1.txt"),
            URL(fileURLWithPath: "/files/new file 2.txt")
        ]
        
        let expected = "new file 3"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDirectoryWithBaseName1() {
        let directoryContents: [URL] = [
            URL(fileURLWithPath: "/files/new file 1.txt")
        ]
        
        let expected = "new file"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDirectoryWithBaseName1AndBaseName2() {
        let directoryContents: [URL] = [
            URL(fileURLWithPath: "/files/new file 1.txt"),
            URL(fileURLWithPath: "/files/new file 2.txt")
        ]
        
        let expected = "new file"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDirectoryWithBaseNameAndBaseName2() {
        let directoryContents: [URL] = [
            URL(fileURLWithPath: "/files/new file.txt"),
            URL(fileURLWithPath: "/files/new file 2.txt")
        ]
        
        let expected = "new file 1"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDirectoryWithBaseNameAndBaseName1AndBaseName3() {
        let directoryContents: [URL] = [
            URL(fileURLWithPath: "/files/new file.txt"),
            URL(fileURLWithPath: "/files/new file 1.txt"),
            URL(fileURLWithPath: "/files/new file 3.txt")
        ]
        
        let expected = "new file 2"
        let actual = generator.makeNewFileName(for: directoryContents)
        
        XCTAssertEqual(expected, actual)
    }
}
