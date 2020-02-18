//
//  AccountViewController.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var balanceValueLabel: UILabel!
    
    let sb = UIStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWalletInfo()
    }
    
    //MARK: - Methods -
    
    private func setWalletInfo() {
        EthereumWalletManager.shared.getWalletInfo { (wallet, error) in
            DispatchQueue.main.async {
                if wallet != nil {
                    self.addressValueLabel.text = wallet?.address
                    self.balanceValueLabel.text = wallet?.balance
                } else {
                    self.showAlert(error ?? "Something went wrong", completion: nil)
                }
            }
        }
    }
    
    //MARK: - Actions -
    
    @IBAction func signTapped(_ sender: Any) {
        let vc = sb.signViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func validateTapped(_ sender: Any) {
        let vc = sb.verificationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changeAcountTapped(_ sender: Any) {
        EthereumWalletManager.shared.privateKey = nil
        KeyChain.remove()
        goToRoot()
    }
}
