//
//  CardCollectionViewController.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/29/21.
//

import UIKit
import Vision
import Photos

class CardCollectionViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    var image: UIImage?
    var setCode: String = ""
    var setNumber: String = ""
    
    lazy var textDetectionRequest: VNRecognizeTextRequest = {
        let request = VNRecognizeTextRequest(completionHandler: self.handleDectectedText)
        request.recognitionLevel = .accurate
        //Note language string is ISO language codes via Apple Docs
        request.recognitionLanguages = ["en_US"]
        return request
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureCollectionView()
        
    }
    
    func configureNavBar() {
        title = "Collection"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCardButtonTapped))
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        // CVcell size
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 4,
                                 height: (view.frame.size.width/3) - 4)
        
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionViewCell.self,
                                forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    @objc func addCardButtonTapped() {
        let alert = UIAlertController(title: "Add To Library", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action) in
            self.presentPhotoPicker(type: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Pick Photo", style: .default, handler: { (action) in
            self.presentPhotoPicker(type: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func presentPhotoPicker(type: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.sourceType = type
        controller.delegate = self
        present(controller, animated: true, completion: nil)
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
        
        DispatchQueue.main.async { [self] in
            if setNumberComponent.text.count >= 3 {
                self.setNumber = "\(setNumberComponent.text.prefix(3))"
            }
            if setComponent.text.count >= 3 {
                self.setCode = "\(setComponent.text.prefix(3))"
            }
            //MARK: - Fix string for api call
            self.setCode = self.setCode.lowercased()
            self.setNumber =  removeLeadingZeros(setNumber: setNumber)
            
            self.pushCardDetailViewController(setName: self.setCode, setNumber: self.setNumber)
        }
        
        
    }
    
    private func removeLeadingZeros(setNumber: String) -> String {
        let temp = Int(setNumber) ?? 0
        return String(temp)
    }
    
    private func pushCardDetailViewController(setName: String, setNumber: String) {
        let cardDetailVC = CardDetailViewController()
        cardDetailVC.setNameCode = setName
        cardDetailVC.setNumberCode = setNumber
        //cardDetailVC.magicCard = magicCard
        //cardDetailVC.modalPresentationStyle = .fullScreen
        //present(cardDetailVC, animated: true)
        navigationController?.pushViewController(cardDetailVC, animated: true)
        print("push code ran")
    }
    
    private func processImage() {
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
    

}

extension CardCollectionViewController: UICollectionViewDelegate {
    
    
}

extension CardCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
        cell.configure(label: "CardName \(indexPath.row)" )
        return cell
    }
 
}

extension CardCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        image = info[.originalImage] as? UIImage
        processImage()
    }
}
