//
//  NetworkError.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 5/30/22.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case serializationFailed
    case generic
    case couldNotDecodeData
    case httpResponseError
    case statusCodeError
    case jsonDecoder
    case unauthorized
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .serializationFailed:
            return NSLocalizedString("Failed trying to serializing the request", comment: "")
        case .generic:
            return NSLocalizedString("Unknown error", comment: "")
        case .couldNotDecodeData:
            return NSLocalizedString("Error decoding data", comment: "")
        case .httpResponseError:
            return NSLocalizedString("Failed to get HTTPURLResponse", comment: "")
        case .statusCodeError:
            return NSLocalizedString("Status code different to 200", comment: "")
        case .jsonDecoder:
            return NSLocalizedString("Failed parsing JSON response", comment: "")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "")
        }
    }
}
