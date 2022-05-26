import XCTest
import Globalalise

class Tests: XCTestCase {
    
    lazy var globalalise: GlobalaliseProtocol = {
        
        let value = Globalalise(availableLocales: [
            Locale(identifier: "en-FR"),
            Locale(identifier: "fr-FR"),
            Locale(identifier: "en-ES"),
            Locale(identifier: "es-ES"),
        ])
        return value
    }()
    
    
    var settingLAR: SettingLARProtocol {
        get{
            return globalalise as! SettingLARProtocol
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        if let local = settingLAR.localizationLocale() {
            print("Last time was selected: \(local)")
        } else {
            
            let regions = try settingLAR.loadAllRegions()
            let selectRegion = try settingLAR.clickOnRegion(regions.last!).last!
            let selectLocale = settingLAR.clickOnLocalizedLanguage(selectRegion)
            settingLAR.switched(to: selectLocale)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
