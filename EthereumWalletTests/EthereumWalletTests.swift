//
//  EthereumWalletTests.swift
//  EthereumWalletTests
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import XCTest
@testable import EthereumWallet

class EthereumWalletTests: XCTestCase {

    
    func testGetWalletInfo() {
        let didFinish = self.expectation(description: #function)
        var walletData : EthereumWallet!
        EthereumWalletManager.shared.privateKey = "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc"
        EthereumWalletManager.shared.getWalletInfo { (result, error) in
            if let wallet = result {
                walletData = wallet
            }
            didFinish.fulfill()
        }
        wait(for: [didFinish], timeout: 5)
        XCTAssertNotNil(walletData.address)
        XCTAssertNotNil(walletData.balance)
        XCTAssertEqual(walletData.address, "0xfC06fE59F38Bb7701833fc2f1c3e2e1D94F858B9")
    }
    
    
    func testSignAndVerifyPersonalMessage() {
        let didFinish = self.expectation(description: #function)
        var success = false
        EthereumWalletManager.shared.privateKey = "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc"
        EthereumWalletManager.shared.signPersonalMessage(message: "hello") { result, error in
            EthereumWalletManager.shared.validatePersonalMessage(message: "hello", qrResultString: (result?.base64EncodedString())!) { result in
                success = result
                didFinish.fulfill()
            }
        }
        wait(for: [didFinish], timeout: 5)
        XCTAssertTrue(success)
    }
    
    func testGetWalletInfoWithInvalidKey() {
        let didFinish = self.expectation(description: #function)
        var walletData : EthereumWallet!
        EthereumWalletManager.shared.privateKey = "0x85f2f20a9db5c18a656480dff1213fb52aed60881dc"
        EthereumWalletManager.shared.getWalletInfo { (result, error) in
            if let wallet = result {
                walletData = wallet
            }
            didFinish.fulfill()
        }
        wait(for: [didFinish], timeout: 5)
        XCTAssertNil(walletData)
    }
    
    func testSignAndVerifyPersonalMessageWithDifferentMessages() {
        let didFinish = self.expectation(description: #function)
        var success = false
        EthereumWalletManager.shared.privateKey = "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc"
        EthereumWalletManager.shared.signPersonalMessage(message: "hello") { result, error in
            EthereumWalletManager.shared.validatePersonalMessage(message: "good", qrResultString: (result?.base64EncodedString())!) { boolResult in
                success = boolResult
                didFinish.fulfill()
            }
        }
        wait(for: [didFinish], timeout: 5)
        XCTAssertTrue(success)
    }
}
