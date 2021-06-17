//
//  MTGError.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/16/21.
//

import Foundation

enum MTGError: String, Error {
    case invalidCardSetCode = "This Set Code created an invalid request. Please try again."
    case invalidCardNameCode = "This Card Name created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again"
    
    
}
