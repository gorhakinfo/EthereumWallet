//
//  UiStoryboard+Common.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/14/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    var qrScannerController: QRScannerController {
        guard let vc = Storyboards.common.value.instantiateViewController(withIdentifier: "QRScannerController") as? QRScannerController else {
            fatalError("QRScannerController couldn't be found in Storyboard file")
        }
        return vc
    }
}
