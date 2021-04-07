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
}
