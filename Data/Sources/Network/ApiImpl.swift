//
//  ApiImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Alamofire
import UIKit
import Common

final public class ApiImpl: Api {
    
    private var sessionManager: Session

#if DEBUG
    public init(configuration: URLSessionConfiguration) {
        sessionManager = Session(configuration: configuration)
    }
#endif

    public init() {
        sessionManager = Session()
    }
    
    public func callApi<T: Decodable>(route: ApiRouter, decodeType type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: NetworkError.cannotConnectToServer)
                return
            }

            sessionManager.request(route)
                .validate(statusCode: 200 ..< 300)
                .responseData { responseData in
                    switch responseData.result {
                    case .success(let data):
                        do {
                            let retVal = try JSONDecoder().decode(type, from: data)
                            continuation.resume(returning: retVal)
                        } catch {
                            continuation.resume(throwing: NetworkError.cannotParseJson)
                        }

                    case .failure:
                        continuation.resume(throwing: NetworkError.cannotConnectToServer)
                    }
                }
        }
    }
    
    public func fetchImageSize(imageUrl urlString: String) async throws -> PreviewMediaSizeDTO {
        return try await withCheckedThrowingContinuation { continuation in
            
            guard let url = URL(string: urlString) else {
                continuation.resume(throwing: NetworkError.badUrl)
                return
            }
            
            guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
                continuation.resume(throwing: NetworkError.badUrl)
                return
            }
            
            let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
                continuation.resume(throwing: NetworkError.cannotFetchImageSize)
                return
            }
            
            guard let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
                  let height = properties[kCGImagePropertyPixelHeight] as? CGFloat else {
                continuation.resume(throwing: NetworkError.cannotFetchImageSize)
                return
            }
            
            let previewSize = PreviewMediaSizeDTO(width: width, height: height)
            continuation.resume(returning: previewSize)
        }
    }
    
    public func fetchImage(route: ApiRouter) async throws -> UIImage {
        return try await withCheckedThrowingContinuation({ [weak self] continuation in
            guard let self else {
                continuation.resume(throwing: NetworkError.cannotFetchImage)
                return
            }
            
            self.sessionManager.request(route)
                .validate(statusCode: 200 ..< 300)
                .responseData { responseData in
                    switch responseData.result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            continuation.resume(throwing: NetworkError.cannotFetchImage)
                            return
                        }
                        
                        continuation.resume(returning: image)
                        
                    case .failure:
                        continuation.resume(throwing: NetworkError.cannotFetchImage)
                    }
                }
        })
    }
}
