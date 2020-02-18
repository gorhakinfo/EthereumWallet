//
//  Storyboards.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation
import UIKit

enum Storyboards: String, Iteratable {
    case root = "Root"
    case main = "Main"
    case common = "Common"
    var value: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
