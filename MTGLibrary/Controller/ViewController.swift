//
//  ViewController.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/10/21.
//

import UIKit
import Vision
import Photos

class ViewController: UIViewController {

    
    let OCRScanview = OCRScanView()
    var image: UIImage?

    
    @IBAction func choosePhoto(_ sender: Any) {
        presentPhotoPicker(type: .photoLibrary)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        presentPhotoPicker(type: .camera)
    }
    
    public func presentPhotoPicker(type: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.sourceType = type
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    lazy var textDetectionRequest: VNRecognizeTextRequest = {
        let request = VNRecognizeTextRequest(completionHandler: self.handleDectectedText)
        request.recognitionLevel = .accurate
        //Note language string is ISO language codes via Apple Docs
        request.recognitionLanguages = ["en_US"]
        return request
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(OCRScanview)
        
        OCRScanview.nameLabel.text = ""
        configureButtons()
    }
    
    func configureButtons(){
        OCRScanview.takePhotoButton.addTarget(self, action: #selector(takePhoto(_:)), for: .touchUpInside )
    }

    
    func processImage() {
        OCRScanview.nameLabel.text = ""
        OCRScanview.setLabel.text = ""
        OCRScanview.setNumberLabel.text = ""
        
        guard let image  = image, let cgImage = image.cgImage else {return}
        
        let requests = [textDetectionRequest]
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .right, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform(requests)
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func handleDectectedText(request:VNRequest?, error: Error?) {
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription, actionTitle: "")
            return
        }
        guard let results = request?.results, results.count > 0 else {
            showAlert(title: "Error", message: "No Text Found", actionTitle: "")
            return
        }
        var components = [CardComponent]()
        
        for result in results {
            if let observation = result as? VNRecognizedTextObservation {
                for text in observation.topCandidates(1) {
                    let component = CardComponent()
                    component.x = observation.boundingBox.origin.x
                    component.y = observation.boundingBox.origin.y
                    component.text = text.string
                    components.append(component)
                }
            }
        }
        
        guard let firstComponent = components.first else {return}
        
        var nameComponent = firstComponent
        var setNumberComponent = firstComponent
        var setComponent = firstComponent
        for component in components {
            if component.x < nameComponent.x && component.y > nameComponent.y {
                nameComponent = component
            }
            
            if component.x < (setNumberComponent.x + 0.05) && component.y < setNumberComponent.y {
                setNumberComponent = setComponent
                setComponent = component
            }
        }
        
        DispatchQueue.main.async {
            self.OCRScanview.nameLabel.text = nameComponent.text
            if setNumberComponent.text.count >= 3 {
                self.OCRScanview.setNumberLabel.text = "\(setNumberComponent.text.prefix(3))"
            }
            if setComponent.text.count >= 3 {
                self.OCRScanview.setLabel.text = "\(setComponent.text.prefix(3))"
            }
        }
    }

    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        image = info[.originalImage] as? UIImage
        processImage()
    }
}
