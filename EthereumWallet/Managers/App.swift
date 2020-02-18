//
//  App.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation
import UIKit

final class App {
    static let shared = App()
    
    func startInterface(in window: UIWindow) {
        var vc: UINavigationController!
        if let receivedData = KeyChain.load(key: PrivateKey.key) {
            EthereumWalletManager.shared.privateKey = String(decoding: receivedData, as: UTF8.self)
            vc = Storyboards.main.value.instantiateInitialViewController()
        } else {
            vc = Storyboards.root.value.instantiateInitialViewController()
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}

