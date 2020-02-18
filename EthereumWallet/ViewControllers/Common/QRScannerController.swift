//
//  QRScannerController.swift
//  EthereumWallet
//
//  Created by Gor Hakobyan on 2/15/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController {
    
    @IBOutlet var topbar: UIView!
    
    var message = ""
    
    private var isBusy = false
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var qrCodeFrameView: UIView?
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.qr]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQR()
    }
    
    // MARK: - Methods -
    
    private func detectCode(decodedStr: String) {
        if isBusy { return }
        isBusy = true
        EthereumWalletManager.shared.validatePersonalMessage(message: message, qrResultString: decodedStr) { success in
            DispatchQueue.main.async {
                self.showAlert(success ? "Signature is valid" : "Invalid Signature") {
                    self.closeViewController()
                }
            }
        }
    }
    
    private func setupQR() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            debugPrint("Failed to get the camera device")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
        } catch {
            debugPrint(error)
            return
        }
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        captureSession.startRunning()
        view.bringSubviewToFront(topbar)
        
        qrCodeFrameView = UIView()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
        layer.videoOrientation = orientation
        videoPreviewLayer?.frame = self.view.bounds
    }
    
    private func closeViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions -
    
    @IBAction func closeTapped(_ sender: Any) {
        closeViewController()
    }
}


extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if supportedCodeTypes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            if metadataObj.stringValue != nil {
                detectCode(decodedStr: metadataObj.stringValue!)
            }
        }
    }
}
