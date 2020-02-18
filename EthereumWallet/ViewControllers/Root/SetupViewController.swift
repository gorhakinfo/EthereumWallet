//
//  SetupViewController.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    @IBOutlet weak var privateKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenViewTapped()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        openAccountViewController()
    }
    
    private func openAccountViewController() {
        guard let privateKey = privateKeyTextField.text, privateKey.count == PrivateKey.length else {
            showAlert("Invalid Private Key", completion: nil)
            return
        }
        let data = Data(privateKey.utf8)
        let status = KeyChain.save(key: PrivateKey.key, data: data)
        EthereumWalletManager.shared.privateKey = privateKey
        debugPrint("status: ", status)
        goToMain()
    }
}


extension SetupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        openAccountViewController()
        return true
    }
}
