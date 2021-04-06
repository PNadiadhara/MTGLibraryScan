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
    var mtgCard: MTGCard! {
        didSet {
            //self.pushCardDetailViewController(magicCard: self.mtgCard)
        }
    }

    
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
    
    func getCardInfo(setCode: String, setNumber: String) {
        NetworkManager.shared.getCards(for: setCode, setNumber: setNumber) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let mtgCardAPI):
                self.mtgCard = mtgCardAPI
                //print(self.mtgCard.oracle_text)
                
            
            case .failure(let error):
                
                print("Result failed: " + error.localizedDescription)
                
                
            }
            
        }
        //return mtgCard
    }
    
    func configureButtons(){
        OCRScanview.takePhotoButton.addTarget(self, action: #selector(takePhoto(_:)), for: .touchUpInside )
        OCRScanview.choosePhotoButton.addTarget(self, action: #selector(choosePhoto(_:)), for: .touchUpInside)
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
            
            print("got to right before funciton call")
            print(self.removeLeadingZeros(setNumber: self.OCRScanview.setNumberLabel.text))
            
            //self.getCardInfo(setCode: self.OCRScanview.setLabel.text.lowercased(), setNumber: self.removeLeadingZeros(setNumber: self.OCRScanview.setNumberLabel.text) )
            let setCode = self.OCRScanview.setLabel.text.lowercased()
            let setNumber = self.removeLeadingZeros(setNumber: self.OCRScanview.setNumberLabel.text)
            //self.getCardInfo(setCode: setCode, setNumber: setNumber)
        
            self.pushCardDetailViewController(setName: setCode, setNumber: setNumber)
            
        }
    }
    
    func removeLeadingZeros(setNumber: String) -> String {
        let temp = Int(setNumber) ?? 0
        return String(temp)
    }
// func pushCardDetailViewController(magicCard: MTGCard)
    func pushCardDetailViewController(setName: String, setNumber: String) {
        let cardDetailVC = CardDetailViewController()
        cardDetailVC.setNameCode = setName
        cardDetailVC.setNumberCode = setNumber
        //cardDetailVC.magicCard = magicCard
        cardDetailVC.modalPresentationStyle = .fullScreen
        present(cardDetailVC, animated: true)
        print("push code ran")
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
