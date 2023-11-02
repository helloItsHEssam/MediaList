//
//  MediaUseCase.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Combine
import SwiftUI

public protocol MediaUseCase {

    func fetchMediaList() -> AnyPublisher<[Media], DomainError>
    func fetchImage(WithImageName imageName: String) -> AnyPublisher<Image, DomainError>
}
