//
//  ApiImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Alamofire

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
        return try await withCheckedThrowingContinuation { continuation in
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
}
