//
//  SingViewController.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/15/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import UIKit

class SingViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenViewTapped()
    }

    @IBAction func signButtonTapped(_ sender: Any) {
        openSignatureVC()
    }
    
    private func openSignatureVC() {
        if let message = messageTextField!.text, messageTextField.text?.count != 0 {
            let sb = UIStoryboard()
            let vc = sb.signatureViewController
            vc.message = message
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlert("Please type your message", completion: nil)
        }
    }
}


extension SingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        openSignatureVC()
        return true
    }
}
