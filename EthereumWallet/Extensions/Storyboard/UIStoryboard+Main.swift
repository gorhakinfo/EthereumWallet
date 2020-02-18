//
//  UIStoryboard+Main.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/14/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    var accountViewController: AccountViewController {
        guard let vc = Storyboards.main.value.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController else {
            fatalError("AccountViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var signViewController: SingViewController {
        guard let vc = Storyboards.main.value.instantiateViewController(withIdentifier: "SingViewController") as? SingViewController else {
            fatalError("SingViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var signatureViewController: SignatureViewController {
        guard let vc = Storyboards.main.value.instantiateViewController(withIdentifier: "SignatureViewController") as? SignatureViewController else {
            fatalError("SignatureViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var verificationViewController: VerificationViewController {
        guard let vc = Storyboards.main.value.instantiateViewController(withIdentifier: "VerificationViewController") as? VerificationViewController else {
            fatalError("VerificationViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}
