//
//  ListText.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import SwiftUI
import MediaListFont
import MediaListColor

public struct ListText: View {
    
    private var content: String
    
    public init(content: String) {
        self.content = content
    }
    
    public var body: some View {
        Text(content)
            .font(Raleway.regular.customFont(basedOnTextStyle: .title2))
            .lineSpacing(1.5)
            .foregroundColor(MediaListTheme.primaryText)
    }
}
