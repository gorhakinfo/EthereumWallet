//
//  QRCodeGenerator.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/15/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import UIKit

class QRCodeGenerator {
    
    class func generateQRCode(from data: Data) -> UIImage? {
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
