//
//  UIStoryboard+Root.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/14/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    var setupViewController: SetupViewController {
        guard let vc = Storyboards.root.value.instantiateViewController(withIdentifier: "SetupViewController") as? SetupViewController else {
            fatalError("SetupViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}
