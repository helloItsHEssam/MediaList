//
//  PreviewImage.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import SwiftUI

public struct PreviewImage: View {
    
    private var placeholder: Image
    private var image: Image?
    
    public init(image: Image?) {
        let placeholder = Image("placeholder", bundle: .module)
        self.init(image: image, placeholder: placeholder)
    }
    
    public init(image: Image?, placeholder: Image) {
        self.image = image
        self.placeholder = placeholder
    }

    public var body: some View {
        let showImage = image ?? placeholder
        showImage
            .resizable()
            .scaledToFill()
    }
}
