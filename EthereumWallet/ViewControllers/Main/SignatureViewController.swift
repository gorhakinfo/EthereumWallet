//
//  SignatureViewController.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/15/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {

    var message = ""
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        messageLabel.text? += #""\#(message)""#
        qrCodeImageView.accessibilityLabel = "QRCodeImageView" // For UI test
        EthereumWalletManager.shared.signPersonalMessage(message: message) { (result, error) in
            DispatchQueue.main.async {
                if let qrData = result {
                    self.qrCodeImageView.image = QRCodeGenerator.generateQRCode(from: qrData)
                } else {
                    self.showAlert(error ?? "Something went wrong", completion: nil)
                }
            }
        }
    }
}
