//
//  ApiRouter.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Alamofire

public enum ApiRouter: URLRequestConvertible {
    
    public typealias Params = [String: Any]
    
    case mediaList
    case fetchImage(imageUrl: String)
    
    public func asURLRequest() throws -> URLRequest {
        
        let httpMethod = getHttpMethod()
        let url = createURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = 20.0
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        let encoding: ParameterEncoding = {
            switch httpMethod {
            default:
                return URLEncoding.queryString
            }
        }()
        
        return try encoding.encode(urlRequest, with: self.getParams())
    }
}

public extension ApiRouter {
    
    func getHttpMethod() -> HTTPMethod {
        switch self {
        case .mediaList, .fetchImage:
            return .get
        }
    }
    
    func getParams() -> Params? {
        return nil
    }
    
    var urlPath: String {
        switch self {
        case .mediaList:
            return "/medialist"
            
        case .fetchImage(let imageUrl):
            return imageUrl
        }
    }
    
    func createURL() -> URL {
        switch self {
        case .fetchImage(let imageUrl):
            return URL(string: imageUrl)!

        default:
            var component = URLComponents()
            component.scheme = "https"
            component.host = "c62881db-c803-4c5e-907e-3b1d843fa7fd.mock.pstmn.io"
            component.path = urlPath
            return component.url!
        }
    }
}
