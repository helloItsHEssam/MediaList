//
//  DetailText.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import SwiftUI
import MediaListFont
import MediaListColor

public struct DetailText: View {
    
    private var content: String
    
    public init(content: String) {
        self.content = content
    }
    
    public var body: some View {
        Text(content)
            .font(Raleway.extraBold.customFont(basedOnTextStyle: .subheadline))
            .lineSpacing(1.5)
            .foregroundColor(MediaListTheme.primaryText)
    }
}
