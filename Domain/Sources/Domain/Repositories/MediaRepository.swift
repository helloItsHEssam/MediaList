//
//  MediaRepository.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

public protocol MediaRepository {
    
    func fetchMediaList() async throws -> [Media]
}
