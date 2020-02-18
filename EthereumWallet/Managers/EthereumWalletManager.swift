//
//  EthereumWallet.swift
//  EthereumWalletManager
//
//  Created by Gor Hakobyan on 2/15/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import Foundation
import web3swift


class EthereumWalletManager {
    
    static let shared = EthereumWalletManager()
    var privateKey: String?
    var walletAddress: String?
    
    private let rinkeby = Web3.InfuraRinkebyWeb3()
    
    func getWalletInfo(completion: @escaping (_ wallet: EthereumWallet?,_ error: String?)->()) {
        DispatchQueue.global(qos: .background).async {
            guard let privateKey = self.privateKey else {
                completion(nil, "Invalid Private Key")
                return
            }
            guard let privateKeyData = Data.fromHex(privateKey) else { return }
            guard let newWallet = try? EthereumKeystoreV3(privateKey: privateKeyData) else { return }
            guard let ethAddress = newWallet.getAddress() else { return }
            guard let balanceResult = try? self.rinkeby.eth.getBalance(address: ethAddress) else {
                completion(nil, "Invalid Private Key")
                return
            }
            guard let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3) else { return }
            self.walletAddress = ethAddress.address
            completion(EthereumWallet(address: ethAddress.address, balance: balanceString), nil)
        }
    }
    
//    func signPersonalMessage(message: String) -> Data? {
//        guard let privateKey = privateKey else { return nil }
//        guard let privateKeyData = Data.fromHex(privateKey) else { return nil }
//        guard let keystore = try? EthereumKeystoreV3(privateKey: privateKeyData) else { return nil }
//        let keystoreManager = KeystoreManager([keystore])
//        rinkeby.addKeystoreManager(keystoreManager)
//        guard let addresses = keystoreManager.addresses else { return nil }
//        do {
//            guard let messageData = message.data(using: .utf8) else { return nil }
//            let signedData = try rinkeby.personal.signPersonalMessage(message: messageData, from: addresses[0])
//            let signedBase64Data = signedData.base64EncodedData()
//            return signedBase64Data
//        } catch {
//            debugPrint(error)
//            return nil
//        }
//    }
    
    func signPersonalMessage(message: String, completion: @escaping (_ result: Data?,_ error: String?)->()) {
        DispatchQueue.global(qos: .background).async {
            guard let privateKey = self.privateKey else {
                completion(nil, "Invalid Private Key")
                return
            }
            guard let privateKeyData = Data.fromHex(privateKey) else { return  }
            guard let keystore = try? EthereumKeystoreV3(privateKey: privateKeyData) else {
                completion(nil, "Invalid Private Key")
                return
            }
            let keystoreManager = KeystoreManager([keystore])
            self.rinkeby.addKeystoreManager(keystoreManager)
            guard let addresses = keystoreManager.addresses else { return }
            do {
                guard let messageData = message.data(using: .utf8) else { return }
                let signedData = try self.rinkeby.personal.signPersonalMessage(message: messageData, from: addresses[0])
                completion(signedData.base64EncodedData(), nil)
            } catch {
                completion(nil, "Invalid Private Key")
            }
        }
    }
    
//    func validatePersonalMessage(message: String, qrResultString: String) -> Bool {
//        if let signature = Data(base64Encoded: qrResultString) {
//            guard let messageData = message.data(using: .utf8) else { return false }
//            let signer = try? rinkeby.personal.ecrecover(personalMessage: messageData, signature: signature)
//            if (signer?.address == walletAddress) {
//                return true
//            } else {
//                return false
//            }
//        }
//        return false
//    }
    
    func validatePersonalMessage(message: String, qrResultString: String, completion: @escaping (_ success: Bool)->()) {
        DispatchQueue.global(qos: .background).async {
            guard let signature = Data(base64Encoded: qrResultString) else {
                completion(false)
                return
            }
            guard let messageData = message.data(using: .utf8) else {
                completion(false)
                return
            }
            let signer = try? self.rinkeby.personal.ecrecover(personalMessage: messageData, signature: signature)
            if (signer?.address == self.walletAddress) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
