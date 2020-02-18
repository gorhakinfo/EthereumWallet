//
//  ViewController.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/13/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardWhenViewTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(_ title: String, completion: (() -> Void)?) {
        let alertVC = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if completion != nil {
                completion!()
            }
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: - Transition -
    
    func goToMain() {
        let vc = Storyboards.main.value.instantiateInitialViewController()
        self.setRoot(vc: vc!, options: .transitionFlipFromRight)
    }
    
    func goToRoot() {
        let vc = Storyboards.root.value.instantiateInitialViewController()
        setRoot(vc: vc!, options: .transitionFlipFromLeft)
    }
    
    private func setRoot(vc: UIViewController, options: UIView.AnimationOptions = [] ) {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        guard let window = keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        vc.view.frame = (rootViewController.view.frame)
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 1.0, options: options, animations: {
            window.rootViewController = vc
        }, completion: { (value) in
        })
    }
}
