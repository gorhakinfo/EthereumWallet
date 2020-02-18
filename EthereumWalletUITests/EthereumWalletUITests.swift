//
//  EthereumWalletUITests.swift
//  EthereumWalletUITests
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import XCTest

class EthereumWalletUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSetup() {
        let app = XCUIApplication()
        let privateKeyTextField = app.textFields["Private Key"]
        if privateKeyTextField.exists {
            privateKeyTextField.tap()
            privateKeyTextField.typeText("0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc")
            app.buttons["Done"].tap()
            sleep(5)
            XCTAssert(app.staticTexts["address"].exists)
            XCTAssert(app.staticTexts["balance"].exists)
        }
    }
    
    func testSigning() {
        let logedApp = XCUIApplication()
        logedApp.buttons["Sign"].tap()
        let messageTextField = logedApp.textFields["Message"]
        messageTextField.tap()
        messageTextField.typeText("hello")
        logedApp.buttons["Sign Message"].tap()
        XCTAssert(logedApp.images["QRCodeImageView"].exists)
    }
    
    func testValidation() {
        let app = XCUIApplication()
        app.buttons["Validate"].tap()
        let messageTextField = app.textFields["Message"]
        messageTextField.tap()
        messageTextField.typeText("hello")
        app.buttons["Validate Message"].tap()
    }
}
