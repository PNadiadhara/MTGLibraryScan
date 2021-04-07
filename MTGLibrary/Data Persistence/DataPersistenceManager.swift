//
//  DataPersistenceManager.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 4/7/21.
//

import Foundation

final class DataPersistenceManager {
    private init() {}
    
    static func documentsDirectory() -> URL  {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Reference for saving img as png to reduce api calls
    
//    if let image = UIImage(named: "example.png") {
//        if let data = image.pngData() {
//            let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
//            try? data.write(to: filename)
//        }
//    }
}
