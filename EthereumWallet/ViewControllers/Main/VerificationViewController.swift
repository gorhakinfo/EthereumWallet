//
//  VerificationViewController.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/15/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var validateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenViewTapped()
    }
    
    func presentQRCodeViewController() {
        let sb = UIStoryboard()
        let vc = sb.qrScannerController
        vc.message = validateTextField.text!
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        presentQRCodeViewController()
    }
}


extension VerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        presentQRCodeViewController()
        return true
    }
}
