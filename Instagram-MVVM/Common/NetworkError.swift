//
//  NetworkError.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 22/6/2021.
//

import Foundation


public enum NetworkError: Error {
    case unknown
    case badParameters
    case badResponse
    case invalidURL
    case invalidJSONObject
    case jsonSerializationFailed
    case parameterEncodingFailed(_ reason: String? = nil)
}

