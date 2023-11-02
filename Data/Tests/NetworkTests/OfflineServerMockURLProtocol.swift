//
//  OfflineServerMockURLProtocol.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

class OfflineServerMockURLProtocol: URLProtocol {
    
    private static var mockResponses = createMockResponse()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url {
            if let apiResponse = OfflineServerMockURLProtocol.mockResponses[url] {
                if let response = apiResponse.httpResponse {
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
                if let data = apiResponse.data {
                    client?.urlProtocol(self, didLoad: data)
                }
                if let error = apiResponse.error {
                    client?.urlProtocol(self, didFailWithError: error)
                }
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {}
    
    private static func createMockResponse() -> [URL: ApiMockResponse] {
        
        let strUrl = "https://c62881db-c803-4c5e-907e-3b1d843fa7fd.mock.pstmn.io/medialist"
        let url = URL(string: strUrl)!
        let data = "offline server".data(using: .utf8)
        let httpResponse = HTTPURLResponse(url: url, statusCode: -1,
                                           httpVersion: nil, headerFields: nil)
        let response = ApiMockResponse(url: url, data: data,
                                       httpResponse: httpResponse,
                                       error: URLError(URLError.Code.cannotConnectToHost))
        
        return [url: response]
    }
}
