//
//  String+extractFileName.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

extension String {
    
    func extractFileName() -> String? {
        guard let url = URL(string: self) else {
            return nil
        }
        
        let lastPathComponent = url.lastPathComponent
        let components = lastPathComponent.components(separatedBy: ".")
        
        return components.first
    }
}
